//
//  CTVFLTransaction.m
//  CTVFL
//
//  Created on 2019/3/29.
//

#import <CTVFL/CTVFL-Swift.h>

#import "CTVFLTransaction.h"
#import "CTVFLTransaction+Implicit.h"
#import "CTVFLTransaction+Internal.h"

#import <pthread/pthread.h>

FOUNDATION_EXTERN {
    static void _CTVFLTransactionRunLoopObserverHandler(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);
    static void _CTVFLTransactionTLSDestructor(void * arg);
    
    /// Why don't use C++ `thread_local` + `std::unique_ptr`? Because god
    /// damn Carthage builds for non-active architectures, and some of
    /// those architectures don't support C++ 11 thread local storage!
    static pthread_key_t _CTVFLTransactionTLSKey = 0;
}

#pragma mark -

@interface CTVFLTransaction()
@end


@implementation CTVFLTransaction(Implicit)
+ (BOOL)_isImplicit
{
    return CTVFL::Transaction::levelsCount() == 1;
}

+ (BOOL)_hasNoTransactionsRunning
{
    return CTVFL::Transaction::levelsCount() == 0;
}
@end

@implementation CTVFLTransaction
+ (void)begin
{
    CTVFL::Transaction::begin(true);
}

+ (void)commit
{
    CTVFL::Transaction::commit();
}

+ (NSArray<NSLayoutConstraint *> *)constraints
{
    auto constraints = [[NSMutableArray alloc] init];
    for (auto &constraint: CTVFL::Transaction::constraints()) {
        [constraints addObject: constraint];
    }
    return [constraints copy];
}

+ (void)addConstraint:(NSLayoutConstraint *)constraint
{
    CTVFL::Transaction::addConstraint(constraint, false, true);
}

+ (void)addConstraint:(NSLayoutConstraint *)constraint enforces:(BOOL)enforces
{
    CTVFL::Transaction::addConstraint(constraint, enforces, true);
}

+ (void)addConstraints:(NSArray<NSLayoutConstraint *> *)constraints
{
    CTVFL::Transaction::addConstraints(constraints, false, true);
}

+ (void)addConstraints:(NSArray<NSLayoutConstraint *> *)constraints enforces:(BOOL)enforces
{
    CTVFL::Transaction::addConstraints(constraints, enforces, true);
}

+ (CTVFLEvaluationContext *)sharedEvaluationContext
{
    return CTVFL::Transaction::sharedEvaluationContext();
}
@end

#pragma mark -

namespace CTVFL {
#pragma mark Transaction
    Transaction::Transaction(void):
    _levels_(std::make_unique<std::list<Level>>()),
    _sharedEvaluationContext_(nil),
    _runLoopObserver_(NULL)
    {
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init(&mutexattr);
        auto currentRunLoop = CFRunLoopGetCurrent();
        CFOptionFlags activities = kCFRunLoopAfterWaiting | kCFRunLoopExit;
        _runLoopObserver_ = CFRunLoopObserverCreate(kCFAllocatorDefault, activities, YES, 2147483647, &_CTVFLTransactionRunLoopObserverHandler, NULL);
        CFRunLoopAddObserver(currentRunLoop, _runLoopObserver_, kCFRunLoopCommonModes);
    }
    
    Transaction::~Transaction(void) {
        _levels_ -> clear();
        _levels_.reset();
        _sharedEvaluationContext_ = nil;
        if (_runLoopObserver_) {
            CFRunLoopObserverInvalidate(_runLoopObserver_);
            auto currentRunLoop = CFRunLoopGetCurrent();
            CFRunLoopRemoveObserver(currentRunLoop, _runLoopObserver_, kCFRunLoopCommonModes);
        }
    }
    
    void Transaction::begin(bool ensuresImplicit) {
        if (ensuresImplicit) {
            threadLocal()._ensureImplicit();
        }
        threadLocal()._push();
    }
    
    void Transaction::commit(void) {
        threadLocal()._pop();
    }
    
    void Transaction::addConstraint(NSLayoutConstraint * constraint, bool enforces, bool ensuresImplicit) {
        if (ensuresImplicit) {
            threadLocal()._ensureImplicit();
        }
        threadLocal().topLevel().addConstraint(constraint, enforces);
    }
    
    void Transaction::addConstraints(NSArray<NSLayoutConstraint *> * constraints, bool enforces, bool ensuresImplicit) {
        if (ensuresImplicit) {
            threadLocal()._ensureImplicit();
        }
        threadLocal().topLevel().addConstraints(constraints, enforces);
    }
    
    std::list<NSLayoutConstraint *>& Transaction::constraints(void) {
        return threadLocal().topLevel().constraints();
    }
    
    CTVFLEvaluationContext * Transaction::sharedEvaluationContext() {
        return threadLocal()._sharedEvaluationContext();
    }
    
    void Transaction::ensureImplicit(void) {
        threadLocal()._ensureImplicit();
    }
    
    void Transaction::_push(void) {
        _levels_ -> emplace_back(!_levels_ -> empty());
    }
    
    void Transaction::_pop(void) {
        NSCAssert(!_levels_ -> empty(), @"Popping from an empty transaction stack.");
        _levels_ -> pop_back();
    }
    
    void Transaction::_ensureImplicit(void) {
        if (_levels_ -> empty()) {
            _push();
        }
    }
    
    Transaction& Transaction::threadLocal(void) {
        if (Transaction * transaction = static_cast<Transaction *>(pthread_getspecific(_CTVFLTransactionTLSKey))) {
            return * transaction;
        } else {
            CTVFL::Transaction * newTransaction = new CTVFL::Transaction();
            pthread_setspecific(_CTVFLTransactionTLSKey, newTransaction);
            return * newTransaction;
        }
    }
    
    Transaction::Level& Transaction::topLevel(void) {
        return threadLocal()._topLevel();
    }
    
    size_t Transaction::levelsCount(void) {
        return threadLocal()._levelsCount();
    }
    
    Transaction::Level& Transaction::_topLevel(void) {
        return _levels_ -> back();
    }
    
    size_t Transaction::_levelsCount(void) {
        return _levels_ -> size();
    }
    
    CTVFLEvaluationContext * Transaction::_sharedEvaluationContext() {
        if (_sharedEvaluationContext_) {
            return _sharedEvaluationContext_;
        } else {
            _sharedEvaluationContext_ = [[CTVFLEvaluationContext alloc] init];
            return _sharedEvaluationContext_;
        }
    }
    
#pragma mark Transaction::Level
    Transaction::Level::Level(bool collectsConstraints):
    _collectsConstraints(collectsConstraints),
    _constraints_(std::make_unique<std::list<NSLayoutConstraint *>>())
    { }
    
    Transaction::Level::~Level(void) {
        [threadLocal().sharedEvaluationContext() evict];
        _constraints_ -> clear();
        _constraints_.reset();
    }
    
    void Transaction::Level::addConstraint(NSLayoutConstraint * constraint, bool enforces) {
        if (_collectsConstraints || enforces) {
            _constraints_ -> push_back(constraint);
        }
    }
    
    void Transaction::Level::addConstraints(NSArray<NSLayoutConstraint *> * constraints, bool enforces) {
        if (_collectsConstraints || enforces) {
            [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * constraint, NSUInteger idx, BOOL * _Nonnull stop) {
                _constraints_ -> push_back(constraint);
            }];
        }
    }
    
    std::list<NSLayoutConstraint *>& Transaction::Level::constraints(void) {
        return * _constraints_;
    }
}

#pragma mark -

void _CTVFLTransactionRunLoopObserverHandler(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    if (CTVFL::Transaction::levelsCount() > 0) {
        CTVFL::Transaction::commit();
        if (CTVFL::Transaction::levelsCount() > 0) {
#if DEBUG
            NSLog(@"Unbalanced calls to [CTVFLTransaction +begin] and [CTVFLTransaction +commit] detected!");
#endif
            while (CTVFL::Transaction::levelsCount() > 0) {
                CTVFL::Transaction::commit();
            }
        }
    }
}

/// pthread specific data destroyer invoked by `pthread_exit()`, and
/// the app exit by invoking `exit()`. Thus pthread specific data on
/// main thread would not be cleaned.
///
void _CTVFLTransactionTLSDestructor(void * arg) {
    CTVFL::Transaction * transaction = static_cast<CTVFL::Transaction *>(pthread_getspecific(_CTVFLTransactionTLSKey));
    delete transaction;
}

__attribute__((constructor))
void _InitCTVFLTransaction(void) {
    // TLS
    pthread_key_create(&_CTVFLTransactionTLSKey, &_CTVFLTransactionTLSDestructor);
    
    // Create a transaction for main thread by accessing the lazy
    // initializing getter. Run Loop observer is also get ready at the
    // same time.
    //
    CTVFL::Transaction::threadLocal();
    CTVFL::Transaction::ensureImplicit();
}

__attribute__((destructor))
void _DeinitCTVFLTransaction(void) {
    // TLS
    pthread_key_delete(_CTVFLTransactionTLSKey);
}

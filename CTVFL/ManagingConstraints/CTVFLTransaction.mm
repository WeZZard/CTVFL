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
    static void _CTVFLTransactionCleanupTLS(void * arg);
}

pthread_key_t _CTVFLTransactionKey = 0;

CFRunLoopObserverRef _mainThreadRunLoopObserver = NULL;

#pragma mark -

@interface CTVFLTransaction() {
    CTVFL::Transaction::Level * _level;
}
@property (nonatomic, class, readonly) CTVFLTransaction * threadLocal;

- (instancetype)initWithLevel:(CTVFL::Transaction::Level *)level;
@end


@implementation CTVFLTransaction(Implicit)
+ (BOOL)_isImplicit
{
    CTVFL::Transaction::lock();
    BOOL isImplicit = CTVFL::Transaction::threadLocal().levelsCount() == 1;
    CTVFL::Transaction::unlock();
    return isImplicit;
}

+ (BOOL)_hasNoTransactionsRunning
{
    CTVFL::Transaction::lock();
    BOOL _hasNoTransactionsRunning = CTVFL::Transaction::threadLocal().levelsCount() == 0;
    CTVFL::Transaction::unlock();
    return _hasNoTransactionsRunning;
}
@end

@implementation CTVFLTransaction
- (instancetype)initWithLevel:(CTVFL::Transaction::Level *)level
{
    self = [super init];
    if (self) {
        _level = level;
    }
    return self;
}

+ (CTVFLTransaction *)threadLocal
{
    CTVFL::Transaction::lock();
    CTVFLTransaction * transaction = CTVFL::Transaction::threadLocal().topLevel().transaction();
    CTVFL::Transaction::unlock();
    return transaction;
}

+ (void)begin
{
    CTVFL::Transaction::lock();
    CTVFL::Transaction::begin();
    CTVFL::Transaction::unlock();
}

+ (void)commit
{
    CTVFL::Transaction::lock();
    CTVFL::Transaction::commit();
    CTVFL::Transaction::unlock();
}

+ (NSArray<NSLayoutConstraint *> *)constraints
{
    auto constraints = [[NSMutableArray alloc] init];
    CTVFL::Transaction::lock();
    for (auto &constraint: [self threadLocal] -> _level -> constraints()) {
        [constraints addObject: constraint];
    }
    CTVFL::Transaction::unlock();
    return [constraints copy];
}

+ (void)addConstraint:(NSLayoutConstraint *)constraint
{
    CTVFL::Transaction::lock();
    CTVFL::Transaction::threadLocal().topLevel().addConstraint(constraint, false);
    CTVFL::Transaction::unlock();
}

+ (void)addConstraint:(NSLayoutConstraint *)constraint enforces:(BOOL)enforces
{
    CTVFL::Transaction::lock();
    CTVFL::Transaction::threadLocal().topLevel().addConstraint(constraint, enforces);
    CTVFL::Transaction::unlock();
}

+ (void)addConstraints:(NSArray<NSLayoutConstraint *> *)constraints
{
    CTVFL::Transaction::lock();
    CTVFL::Transaction::threadLocal().topLevel().addConstraints(constraints, false);
    CTVFL::Transaction::unlock();
}

+ (void)addConstraints:(NSArray<NSLayoutConstraint *> *)constraints enforces:(BOOL)enforces
{
    CTVFL::Transaction::lock();
    CTVFL::Transaction::threadLocal().topLevel().addConstraints(constraints, enforces);
    CTVFL::Transaction::unlock();
}

+ (CTVFLEvaluationContext *)sharedEvaluationContext
{
    CTVFL::Transaction::lock();
    CTVFLEvaluationContext * sharedEvaluationContext = CTVFL::Transaction::threadLocal().sharedEvaluationContext();
    CTVFL::Transaction::unlock();
    return sharedEvaluationContext;
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
        pthread_mutex_init(&_lock_, &mutexattr);
        if (![NSThread isMainThread]) {
            auto currentRunLoop = CFRunLoopGetCurrent();
            CFOptionFlags activities = kCFRunLoopAfterWaiting | kCFRunLoopExit;
            _runLoopObserver_ = CFRunLoopObserverCreate(kCFAllocatorDefault, activities, YES, 2147483647, &_CTVFLTransactionRunLoopObserverHandler, NULL);
            CFRunLoopAddObserver(currentRunLoop, _runLoopObserver_, kCFRunLoopCommonModes);
        }
    }
    
    Transaction::~Transaction(void) {
        pthread_mutex_destroy(&_lock_);
        _levels_ -> clear();
        _levels_.reset();
        _sharedEvaluationContext_ = nil;
        if (_runLoopObserver_) {
            CFRunLoopObserverInvalidate(_runLoopObserver_);
            auto currentRunLoop = CFRunLoopGetCurrent();
            CFRunLoopRemoveObserver(currentRunLoop, _runLoopObserver_, kCFRunLoopCommonModes);
        }
    }
    
    void Transaction::begin(void) {
        threadLocal().push();
    }
    
    void Transaction::commit(void) {
        threadLocal().pop();
    }
    
    void Transaction::lock(void) {
        threadLocal()._lock();
    }
    
    void Transaction::unlock(void) {
        threadLocal()._unlock();
    }
    
    void Transaction::push(void) {
        _levels_ -> emplace_back(!_levels_ -> empty());
    }
    
    void Transaction::pop(void) {
        NSCAssert(!_levels_ -> empty(), @"Popping from an empty transaction stack.");
        _levels_ -> pop_back();
    }
    
    void Transaction::_lock(void) {
        while (!pthread_mutex_trylock(&_lock_)) {
            ;
        }
    }
    
    void Transaction::_unlock(void) {
        pthread_mutex_unlock(&_lock_);
    }
    
    Transaction& Transaction::threadLocal(void) {
        if (Transaction * transaction = static_cast<Transaction *>(pthread_getspecific(_CTVFLTransactionKey))) {
            return * transaction;
        } else {
            CTVFL::Transaction * newTransaction = new CTVFL::Transaction();
            pthread_setspecific(_CTVFLTransactionKey, newTransaction);
            return * newTransaction;
        }
    }
    
    Transaction::Level& Transaction::topLevel(void) {
        return _levels_ -> back();
    }
    
    size_t Transaction::levelsCount(void) {
        return _levels_ -> size();
    }
    
    CTVFLEvaluationContext * Transaction::sharedEvaluationContext() {
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
    _constraints_(std::make_unique<std::list<NSLayoutConstraint *>>()),
    _transaction_(nil)
    { }
    
    Transaction::Level::~Level(void)
    {
        [threadLocal().sharedEvaluationContext() evict];
        _constraints_ -> clear();
        _constraints_.reset();
        _transaction_ = nil;
    }
    
    CTVFLTransaction * Transaction::Level::transaction(void) {
        if (_transaction_ == nil) {
            _transaction_ = [[CTVFLTransaction alloc] initWithLevel: this];
        }
        return _transaction_;
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
    if (activity & kCFRunLoopAfterWaiting) {
        if (CTVFL::Transaction::threadLocal().levelsCount() > 0) {
            [CTVFLTransaction commit];
            if (CTVFL::Transaction::threadLocal().levelsCount() > 0) {
#if DEBUG
                NSLog(@"Unbalanced calls to [CTVFLTransaction +begin] and [CTVFLTransaction +commit] detected!");
#endif
                while (CTVFL::Transaction::threadLocal().levelsCount() > 0) {
                    CTVFL::Transaction::threadLocal().pop();
                }
            }
        }
    }
    
    if (activity & kCFRunLoopExit) {
        [CTVFLTransaction begin];
    }
}

void _CTVFLTransactionCleanupTLS(void * arg) {
    CTVFL::Transaction * transaction = static_cast<CTVFL::Transaction *>(pthread_getspecific(_CTVFLTransactionKey));
    delete transaction;
}

__attribute__((constructor))
void _InitCTVFLTransaction(void) {
    // TLS
    pthread_key_create(&_CTVFLTransactionKey, &_CTVFLTransactionCleanupTLS);
    
    // Main thread Run Loop
    auto currentRunLoop = CFRunLoopGetMain();
    CFOptionFlags activities = kCFRunLoopAfterWaiting | kCFRunLoopExit;
    _mainThreadRunLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, activities, YES, 2147483647, &_CTVFLTransactionRunLoopObserverHandler, NULL);
    CFRunLoopAddObserver(currentRunLoop, _mainThreadRunLoopObserver, kCFRunLoopCommonModes);
}

__attribute__((destructor))
void _DeinitCTVFLTransaction(void) {
    // Main thread Run Loop
    CFRunLoopObserverInvalidate(_mainThreadRunLoopObserver);
    auto currentRunLoop = CFRunLoopGetCurrent();
    CFRunLoopRemoveObserver(currentRunLoop, _mainThreadRunLoopObserver, kCFRunLoopCommonModes);
    
    // TLS
    pthread_key_delete(_CTVFLTransactionKey);
}

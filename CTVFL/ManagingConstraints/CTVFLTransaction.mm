//
//  CTVFLTransaction.m
//  CTVFL
//
//  Created on 2019/3/29.
//

#import <CTVFL/CTVFL-Swift.h>

#import "CTVFLTransaction.h"
#import "CTVFLTransaction+Internal.h"

FOUNDATION_EXTERN {
    static void _CTVFLTransactionRunLoopObserverHandler(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);
}

thread_local std::unique_ptr<CTVFL::Transaction> _threadLocalTransaction = std::make_unique<CTVFL::Transaction>();
thread_local BOOL _hasTransactionBegan = NO;

#pragma mark -

@interface CTVFLTransaction() {
    CTVFL::Transaction::Level * _level;
}

@property (nonatomic, class, readonly) CTVFLTransaction * threadLocal;

- (instancetype)initWithLevel:(CTVFL::Transaction::Level *)level;

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
    return CTVFL::Transaction::threadLocal().topLevel().transaction();
}

+ (void)begin
{
    CTVFL::Transaction::begin();
}

+ (void)commit
{
    CTVFL::Transaction::commit();
}

+ (NSArray<NSLayoutConstraint *> *)constraints
{
    auto constraints = [[NSMutableArray alloc] init];
    for (auto &constraint: [self threadLocal] -> _level -> constraints()) {
        [constraints addObject: constraint];
    }
    return [constraints copy];
}

+ (void)addConstraint:(NSLayoutConstraint *)constraint
{
    CTVFL::Transaction::threadLocal().topLevel().addConstraint(constraint, false);
}

+ (void)addConstraint:(NSLayoutConstraint *)constraint enforces:(BOOL)enforces
{
    CTVFL::Transaction::threadLocal().topLevel().addConstraint(constraint, enforces);
}

+ (void)addConstraints:(NSArray<NSLayoutConstraint *> *)constraints
{
    CTVFL::Transaction::threadLocal().topLevel().addConstraints(constraints, false);
}

+ (void)addConstraints:(NSArray<NSLayoutConstraint *> *)constraints enforces:(BOOL)enforces
{
    CTVFL::Transaction::threadLocal().topLevel().addConstraints(constraints, enforces);
}

+ (CTVFLEvaluationContext *)sharedEvaluationContext
{
    return CTVFL::Transaction::threadLocal().sharedEvaluationContext();
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
        
        if (![NSThread isMainThread]) {
            auto currentRunLoop = CFRunLoopGetCurrent();
            CFOptionFlags activities = kCFRunLoopBeforeWaiting | kCFRunLoopExit;
            _runLoopObserver_ = CFRunLoopObserverCreate(kCFAllocatorDefault, activities, YES, 2147483647, &_CTVFLTransactionRunLoopObserverHandler, NULL);
            CFRunLoopAddObserver(currentRunLoop, _runLoopObserver_, kCFRunLoopCommonModes);
        }
    }
    
    Transaction::~Transaction(void) {
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
    
    void Transaction::push(void) {
        _levels_ -> emplace_back(!_levels_ -> empty());
    }
    
    void Transaction::pop(void) {
        NSCAssert(!_levels_ -> empty(), @"Popping from an empty transaction stack.");
        _levels_ -> pop_back();
    }
    
    Transaction& Transaction::threadLocal(void) {
        return *_threadLocalTransaction.get();
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
        [_threadLocalTransaction -> sharedEvaluationContext() evict];
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
        return *_constraints_.get();
    }
}

#pragma mark -

void _CTVFLTransactionRunLoopObserverHandler(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    if (activity & kCFRunLoopBeforeWaiting) {
        if (_hasTransactionBegan) {
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
        if (!_hasTransactionBegan) {
            _hasTransactionBegan = YES;
        }
    }
}

CFRunLoopObserverRef _mainThreadRunLoopObserver = NULL;

__attribute__((constructor))
extern "C" void _InitCTVFLTransactionForMainThread(void) {
    auto currentRunLoop = CFRunLoopGetMain();
    CFOptionFlags activities = kCFRunLoopBeforeWaiting | kCFRunLoopExit;
    _mainThreadRunLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, activities, YES, 2147483647, &_CTVFLTransactionRunLoopObserverHandler, NULL);
    CFRunLoopAddObserver(currentRunLoop, _mainThreadRunLoopObserver, kCFRunLoopCommonModes);
}

__attribute__((destructor))
extern "C" void _DeinitCTVFLTransactionForMainThread(void) {
    CFRunLoopObserverInvalidate(_mainThreadRunLoopObserver);
    auto currentRunLoop = CFRunLoopGetCurrent();
    CFRunLoopRemoveObserver(currentRunLoop, _mainThreadRunLoopObserver, kCFRunLoopCommonModes);
}

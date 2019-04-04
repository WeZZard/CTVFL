//
//  CTVFLTransaction_ImplicitTests.m
//  CTVFL
//
//  Created on 2019/3/29.
//

#import <XCTest/XCTest.h>

#import "CTVFLTransaction+Implicit.h"

@interface CTVFLTransaction_ImplicitTests: XCTestCase {
    NSThread * _thread;
    NSLock * _lock;
    NSMutableArray * _blocks;
}
@end

@implementation CTVFLTransaction_ImplicitTests
- (void)setUp
{
    _lock = [[NSLock alloc] init];
    _blocks = [[NSMutableArray alloc] init];
    _thread = [[NSThread alloc] initWithTarget: self selector: @selector(performTransactionTests) object: nil];
    [_thread start];
}

- (void)tearDown
{
    _thread = nil;
    _lock = nil;
    _blocks = nil;
}

- (void)performTransactionTests
{
    if ([_lock tryLock]) {
        
        [_blocks enumerateObjectsUsingBlock:^(void (^block)(CTVFLTransaction_ImplicitTests *), NSUInteger idx, BOOL * _Nonnull stop) {
            block(self);
        }];
        
        [_lock unlock];
    }
}

- (void)addTransactionTestWithBlock:(void (^)(CTVFLTransaction_ImplicitTests *))block
{
    [_lock lock];
    [_blocks addObject: block];
    [_lock unlock];
}

- (void)waitForTransactionTests
{
    while (![_thread isFinished]) {
        usleep(1000);
    }
}

- (void)test_isImplicit_returnsFalse_whenNothingCalledBefore
{
    [self addTransactionTestWithBlock: ^(CTVFLTransaction_ImplicitTests * self){
        XCTAssertFalse([CTVFLTransaction _isImplicit]);
    }];
    
    [self waitForTransactionTests];
}

- (void)test_hasTransactionsRunning_returnsTrue_whenNothingCalledBefore
{
    [self addTransactionTestWithBlock: ^(CTVFLTransaction_ImplicitTests * self){
        XCTAssertTrue([CTVFLTransaction _hasNoTransactionsRunning]);
    }];
    
    [self waitForTransactionTests];
}

- (void)testBegin_entersIntoAnExplicitTransaction
{
    [self addTransactionTestWithBlock: ^(CTVFLTransaction_ImplicitTests * self){
        XCTAssertFalse([CTVFLTransaction _isImplicit]);
        XCTAssertTrue([CTVFLTransaction _hasNoTransactionsRunning]);
        [CTVFLTransaction begin];
        XCTAssertFalse([CTVFLTransaction _isImplicit]);
        XCTAssertFalse([CTVFLTransaction _hasNoTransactionsRunning]);
        [CTVFLTransaction commit];
        XCTAssertTrue([CTVFLTransaction _isImplicit]);
        XCTAssertFalse([CTVFLTransaction _hasNoTransactionsRunning]);
    }];
    
    [self waitForTransactionTests];
}

- (void)testCommit_exitsFromANonImplicitTransaction
{
    [self addTransactionTestWithBlock: ^(CTVFLTransaction_ImplicitTests * self){
        XCTAssertFalse([CTVFLTransaction _isImplicit]);
        XCTAssertTrue([CTVFLTransaction _hasNoTransactionsRunning]);
        [CTVFLTransaction begin];
        XCTAssertFalse([CTVFLTransaction _isImplicit]);
        XCTAssertFalse([CTVFLTransaction _hasNoTransactionsRunning]);
        [CTVFLTransaction commit];
        XCTAssertTrue([CTVFLTransaction _isImplicit]);
        XCTAssertFalse([CTVFLTransaction _hasNoTransactionsRunning]);
    }];
    
    [self waitForTransactionTests];
}
@end


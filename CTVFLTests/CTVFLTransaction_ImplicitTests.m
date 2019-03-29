//
//  CTVFLTransaction_ImplicitTests.m
//  CTVFL
//
//  Created on 2019/3/29.
//

#import <XCTest/XCTest.h>

#import "CTVFLTransaction+Implicit.h"

@interface CTVFLTransaction_ImplicitTests : XCTestCase

@end

@implementation CTVFLTransaction_ImplicitTests
- (void)testImplicitTransactionIsRunning
{
    XCTAssertTrue([CTVFLTransaction _isImplicit]);
}

- (void)testHasTransactionsRunning
{
    XCTAssertFalse([CTVFLTransaction _hasNoTransactionsRunning]);
}

- (void)testBegin_entersANonImplicitTransaction
{
    XCTAssertTrue([CTVFLTransaction _isImplicit]);
    [CTVFLTransaction begin];
    XCTAssertFalse([CTVFLTransaction _isImplicit]);
    [CTVFLTransaction commit];
    XCTAssertTrue([CTVFLTransaction _isImplicit]);
}

- (void)testCommit_escapesFromANonImplicitTransaction
{
    XCTAssertTrue([CTVFLTransaction _isImplicit]);
    [CTVFLTransaction begin];
    XCTAssertFalse([CTVFLTransaction _isImplicit]);
    [CTVFLTransaction commit];
    XCTAssertTrue([CTVFLTransaction _isImplicit]);
}
@end

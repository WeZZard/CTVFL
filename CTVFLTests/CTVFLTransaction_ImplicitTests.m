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
@end

//
//  CTVFLTransactionTests.m
//  CTVFL
//
//  Created on 2019/3/29.
//

#import <XCTest/XCTest.h>

#import "CTVFLTransaction+Implicit.h"

@interface CTVFLTransactionTests : XCTestCase

@end

@implementation CTVFLTransactionTests
- (void)testImplicitTransactionIsRunning
{
    XCTAssertTrue([CTVFLTransaction _isImplicit]);
}

- (void)testHasTransactionsRunning
{
    XCTAssertFalse([CTVFLTransaction _hasNoTransactionsRunning]);
}
@end

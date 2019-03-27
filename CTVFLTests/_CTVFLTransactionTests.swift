//
//  _CTVFLTransactionTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class _CTVFLTransactionTests: XCTestCase {
    var context: _CTVFLTransaction!
    
    override func setUp() {
        super.setUp()
        context = _CTVFLTransaction()
    }
    
    override func tearDown() {
        super.tearDown()
        context = nil
    }
    
    func testInit() {
        XCTAssert(context.handlers.isEmpty)
    }
    
    func testManagingContextStack() {
        XCTAssert(_CTVFLTransaction.shared == nil)
        
        XCTAssert(_CTVFLTransaction.contexts.isEmpty)
        
        let shared = _CTVFLTransaction.push()
        
        XCTAssert(_CTVFLTransaction.contexts.elementsEqual([shared], by: {$0 === $1}))
        
        XCTAssert(_CTVFLTransaction.shared === shared)
        
        _CTVFLTransaction.pop()
        
        XCTAssert(_CTVFLTransaction.contexts.isEmpty)
        
        XCTAssert(_CTVFLTransaction.shared == nil)
    }
    
    func testPushConstraints() {
        
    }
}

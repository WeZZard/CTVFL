//
//  CTVFLLayoutableTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLLayoutableTests: XCTestCase {
    var view: CTVFLView!
    var layoutable: CTVFLLayoutable!
    
    override func setUp() {
        super.setUp()
        view = CTVFLView()
        layoutable = CTVFLLayoutable(view)
    }
    
    override func tearDown() {
        super.tearDown()
        layoutable = nil
    }
    
    func testHashValue() {
        XCTAssertEqual(layoutable!.hashValue, ObjectIdentifier(view).hashValue)
    }
    
    func testEqualOperator() {
        let layoutableWithSameView = CTVFLLayoutable(view)
        XCTAssertEqual(layoutable, layoutableWithSameView)
        
        let anotherView = CTVFLView()
        
        let layoutableWithAnotherView = CTVFLLayoutable(anotherView)
        XCTAssertNotEqual(layoutable, layoutableWithAnotherView)
    }
    
    func testInitWithView() {
        let anotherLayoutable = CTVFLLayoutable(view)
        XCTAssert(layoutable == anotherLayoutable)
    }
    
    func test_asAnchorSelector() {
        XCTAssert(layoutable._asAnchorSelector === view)
    }
    
    func testView_makeLayoutable() {
        let view = CTVFLView()
        
        let layoutable = CTVFLView._makeLayoutable(view)
        
        XCTAssert(layoutable._asAnchorSelector === view)
        XCTAssert(layoutable._view === view)
    }
}

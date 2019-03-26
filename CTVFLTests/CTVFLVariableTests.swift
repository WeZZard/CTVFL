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
        layoutable = CTVFLLayoutable(rawValue: view)
    }
    
    override func tearDown() {
        super.tearDown()
        layoutable = nil
    }
    
    func testHashValue() {
        XCTAssertEqual(layoutable!.hashValue, ObjectIdentifier(view).hashValue)
    }
    
    func testEqualOperator() {
        let layoutableWithSameView = CTVFLLayoutable(rawValue: view)
        XCTAssertEqual(layoutable, layoutableWithSameView)
        
        let layoutableWithAnotherView = CTVFLLayoutable(rawValue: CTVFLView())
        XCTAssertNotEqual(layoutable, layoutableWithAnotherView)
    }
    
    func testInitWithView() {
        let anotherLayoutable = CTVFLLayoutable(view)
        XCTAssert(layoutable == anotherLayoutable)
    }
    
    func test_item() {
        XCTAssert(layoutable._item === view)
    }
    
    func testView_makeLayoutable() {
        let view = CTVFLView()
        
        let layoutable = CTVFLView._makeLayoutable(view)
        
        XCTAssert(layoutable._item === view)
        XCTAssert(layoutable.rawValue === view)
    }
}

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
    var view: View!
    var layoutable: CTVFLLayoutable!
    
    override func setUp() {
        super.setUp()
        view = View()
        layoutable = CTVFLLayoutable(rawValue: view)
    }
    
    override func tearDown() {
        super.tearDown()
        layoutable = nil
    }
    
    func testHashValue() {
        XCTAssert(layoutable.hashValue == view.hashValue)
    }
    
    func testEqualOperator() {
        let layoutableWithSameView = CTVFLLayoutable(rawValue: view)
        XCTAssert(layoutable == layoutableWithSameView)
        
        let layoutableWithAnotherView = CTVFLLayoutable(rawValue: View())
        XCTAssert(layoutable != layoutableWithAnotherView)
    }
    
    func testInitWithView() {
        let anotherLayoutable = CTVFLLayoutable(view)
        XCTAssert(layoutable == anotherLayoutable)
    }
    
    func test_item() {
        XCTAssert(layoutable._item === view)
    }
    
    func testView_makeLayoutable() {
        let view = View()
        
        let layoutable = View._makeLayoutable(view)
        
        XCTAssert(layoutable._item === view)
        XCTAssert(layoutable.rawValue === view)
    }
}

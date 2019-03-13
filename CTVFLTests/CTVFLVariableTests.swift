//
//  CTVFLVariableTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLVariableTests: XCTestCase {
    var view: View!
    var variable: CTVFLVariable!
    
    override func setUp() {
        super.setUp()
        view = View()
        variable = CTVFLVariable(rawValue: view)
    }
    
    override func tearDown() {
        super.tearDown()
        variable = nil
    }
    
    func testHashValue() {
        XCTAssert(variable.hashValue == view.hashValue)
    }
    
    func testEqualOperator() {
        let variableWithSameView = CTVFLVariable(rawValue: view)
        XCTAssert(variable == variableWithSameView)
        
        let variableWithAnotherView = CTVFLVariable(rawValue: View())
        XCTAssert(variable != variableWithAnotherView)
    }
    
    func testInitWithView() {
        let anotherVariable = CTVFLVariable(view)
        XCTAssert(variable == anotherVariable)
    }
    
    func test_view() {
        XCTAssert(variable._view === view)
    }
    
    func testView_makeVariable() {
        let view = View()
        
        let variable = View._makeVariable(view)
        
        XCTAssert(variable._view === view)
        XCTAssert(variable.rawValue === view)
    }
}

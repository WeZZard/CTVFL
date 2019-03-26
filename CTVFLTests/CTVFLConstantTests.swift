//
//  CTVFLConstantTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLConstantTests: XCTestCase {
    var float: Float!
    var constant: CTVFLConstant!
    
    override func setUp() {
        super.setUp()
        float = (Float(arc4random_uniform(100)) / Float(arc4random_uniform(100)))
        constant = CTVFLConstant(rawValue: float)
    }
    
    override func tearDown() {
        super.tearDown()
        constant = nil
    }
    
    func testRawValue() {
        XCTAssert(constant.rawValue == float)
    }
    
    func testDescription() {
        XCTAssert(constant.description == float.description)
    }
    
    func testInt_makeConstant() {
        let rawValue = Int(arc4random())
        let rawValueFloatRepresentation = Float(rawValue)
        
        let constant = Int._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueFloatRepresentation)
    }
    
    func testFloat_makeConstant() {
        let rawValue = Float(arc4random())
        let rawValueFloatRepresentation = Float(rawValue)
        
        let constant = Float._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueFloatRepresentation)
    }
    
    func testDouble_makeConstant() {
        let rawValue = Float(arc4random())
        let rawValueFloatRepresentation = Float(rawValue)
        
        let constant = Float._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueFloatRepresentation)
    }
    
    func testCGFloat_makeConstant() {
        let rawValue = CGFloat(arc4random())
        let rawValueFloatRepresentation = Float(rawValue)
        
        let constant = CGFloat._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueFloatRepresentation)
    }
}

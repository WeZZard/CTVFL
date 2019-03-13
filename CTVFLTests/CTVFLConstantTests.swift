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
    var double: Double!
    var constant: CTVFLConstant!
    
    override func setUp() {
        super.setUp()
        double = (Double(arc4random_uniform(100)) / Double(arc4random_uniform(100)))
        constant = CTVFLConstant(rawValue: double)
    }
    
    override func tearDown() {
        super.tearDown()
        constant = nil
    }
    
    func testRawValue() {
        XCTAssert(constant.rawValue == double)
    }
    
    func testDescription() {
        XCTAssert(constant.description == double.description)
    }
    
    func testInt_makeConstant() {
        let rawValue = Int(arc4random())
        let rawValueDoubleRepresentation = Double(rawValue)
        
        let constant = Int._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueDoubleRepresentation)
    }
    
    func testFloat_makeConstant() {
        let rawValue = Float(arc4random())
        let rawValueDoubleRepresentation = Double(rawValue)
        
        let constant = Float._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueDoubleRepresentation)
    }
    
    func testDouble_makeConstant() {
        let rawValue = Double(arc4random())
        let rawValueDoubleRepresentation = Double(rawValue)
        
        let constant = Double._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueDoubleRepresentation)
    }
    
    func testCGFloat_makeConstant() {
        let rawValue = CGFloat(arc4random())
        let rawValueDoubleRepresentation = Double(rawValue)
        
        let constant = CGFloat._makeConstant(rawValue)
        
        XCTAssert(constant.rawValue == rawValueDoubleRepresentation)
    }
}

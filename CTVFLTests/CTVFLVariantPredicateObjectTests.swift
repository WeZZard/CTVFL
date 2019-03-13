//
//  CTVFLVariantPredicateObjectTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

import XCTest

@testable
import CTVFL

class CTVFLVariantPredicateObjectTests: XCTestCase {
    func testConstant() {
        let aConstant = CTVFLConstant(rawValue: Double(arc4random()))
        let aPredicateObject = CTVFLVariantPredicateObject.constant(aConstant)
        let context = CTVFLInlineContext()
        let primitiveVisualFormat = aPredicateObject.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == aConstant.description)
        
        XCTAssert(aPredicateObject == .constant(aConstant))
    }
    
    func testVariable() {
        let aView = View()
        let aVariable = CTVFLVariable(aView)
        let aPredicateObject = CTVFLVariantPredicateObject.variable(aVariable)
        let context = CTVFLInlineContext()
        let primitiveVisualFormat = aPredicateObject.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == context._name(forVariable: aVariable))
        
    }
    
    func testEqualOperator() {
        let aConstant = CTVFLConstant(rawValue: Double(arc4random()))
        let aConstantPredicateObject = CTVFLVariantPredicateObject.constant(aConstant)
        
        let aView = View()
        let aVariable = CTVFLVariable(aView)
        let aVariablePredicateObject = CTVFLVariantPredicateObject.variable(aVariable)
        
        XCTAssert(aConstantPredicateObject == aConstantPredicateObject)
        XCTAssert(aVariablePredicateObject == aVariablePredicateObject)
        XCTAssert(aConstantPredicateObject != aVariablePredicateObject)
    }
}

//
//  CTVFLPredicatedVariableTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLPredicatedVariableTests: XCTestCase {
    func testInitWithVariablePredicates() {
        let view = View()
        let variable = CTVFLVariable(view)
        
        let predicate0 = <=0
        let predicate1 = ==0
        let predicate2 = >=0
        
        let predicates = [predicate0, predicate1, predicate2]
        
        let predicatedVariable = CTVFLPredicatedVariable(
            variable: variable, predicates: predicates
        )
        
        XCTAssert(predicatedVariable._variable == variable)
        
        XCTAssert(predicatedVariable._predicates == predicates)
    }
    
    func testMakePrimitiveVisualFormatWithInlineContext() {
        let view = View()
        let variable = CTVFLVariable(view)
        
        let predicate0 = <=0
        let predicate1 = ==0
        let predicate2 = >=0
        
        let predicates = [predicate0, predicate1, predicate2]
        
        let predicatedVariable = CTVFLPredicatedVariable(
            variable: variable, predicates: predicates
        )
        
        let context = CTVFLInlineContext()
        let primitiveVisualFormat = predicatedVariable.makePrimitiveVisualFormat(with: context)
        
        let variableName = context._name(forVariable: variable)
        
        let predicateString = predicates
            .map({$0.makePrimitiveVisualFormat(with: context)})
            .joined(separator: ",")
        
        let expectedPrimitiveVisualFormat = "[\(variableName)(\(predicateString))]"
        
        XCTAssert(primitiveVisualFormat == expectedPrimitiveVisualFormat)
    }
}

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
    func testEqualOperator() {
        let aConstant = CTVFLConstant(rawValue: Float(arc4random()))
        let aConstantPredicateObject = CTVFLWherePredicateContent.constant(aConstant)
        
        let aView = View()
        let aLayoutable = CTVFLLayoutable(aView)
        let aLayoutablePredicateObject = CTVFLWherePredicateContent.layoutable(aLayoutable)
        
        XCTAssert(aConstantPredicateObject == aConstantPredicateObject)
        XCTAssert(aLayoutablePredicateObject == aLayoutablePredicateObject)
        XCTAssert(aConstantPredicateObject != aLayoutablePredicateObject)
    }
}

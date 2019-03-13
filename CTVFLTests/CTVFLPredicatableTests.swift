//
//  CTVFLPredicatableTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLPredicatableTests: XCTestCase {
    func testViewWhere() {
        let view = View()
        
        let predicate0 = <=0
        let predicate1 = ==0
        let predicate2 = >=0
        
        let predicatedVariable = view.where(predicate0, predicate1, predicate2)
        
        XCTAssert(predicatedVariable._variable == CTVFLVariable(view))
        
        XCTAssert(predicatedVariable._predicates == [predicate0, predicate1, predicate2])
    }
}

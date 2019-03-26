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
        
        let predicatedLayoutable = view.where(predicate0, predicate1, predicate2)
        
        XCTAssert(predicatedLayoutable._layoutable == CTVFLLayoutable(view))
        
        XCTAssert(predicatedLayoutable._predicates == [predicate0, predicate1, predicate2])
    }
}

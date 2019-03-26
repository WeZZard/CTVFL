//
//  CTVFLPredicatedLayoutableTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLPredicatedLayoutableTests: XCTestCase {
    func testInitWithLayoutablePredicates() {
        let view = CTVFLView()
        let layoutable = CTVFLLayoutable(view)
        
        let predicate0 = <=0
        let predicate1 = ==0
        let predicate2 = >=0
        
        let predicates = [predicate0, predicate1, predicate2]
        
        let predicatedLayoutable = CTVFLPredicatedLayoutable(
            layoutable: layoutable, predicates: predicates
        )
        
        XCTAssert(predicatedLayoutable._layoutable == layoutable)
        
        // XCTAssert(predicatedLayoutable._predicates == predicates)
    }
}

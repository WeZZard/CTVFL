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
        
        let predicates: [CTVFLPredicating] = [predicate0, predicate1, predicate2]
        
        let predicatedLayoutable = CTVFLPredicatedLayoutable(
            layoutable: layoutable, predicates: predicates
        )
        
        XCTAssertEqual(predicatedLayoutable._layoutable, layoutable)
        
        XCTAssertEqual(predicatedLayoutable._predicates.count, predicates.count)
    }
}

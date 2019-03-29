//
//  CTVFLTransactionTests.swift
//  CTVFL
//
//  Created on 2019/3/29.
//

import XCTest

@testable
import CTVFL

class CTVFLTransactionTests: XCTestCase {
    let queue = DispatchQueue(label: "com.WeZZard.CTVFL.CTVFLTests.CTVFLTransactionTests", attributes: [.concurrent])
    
    var rootView: CTVFLView!
    var view1: CTVFLView!
    var view2: CTVFLView!
    var view3: CTVFLView!
    
    override func setUp() {
        super.setUp()
        rootView = CTVFLView()
        
        view1 = CTVFLView()
        view2 = CTVFLView()
        view3 = CTVFLView()
        
        rootView.addSubview(view1)
        rootView.addSubview(view2)
        rootView.addSubview(view3)
    }
    
    func testBeginAndCommit_wontCrash_withConcurrentQueue() {
        let expectation = XCTestExpectation(description: "Add constraints to CTVFLTransaction.")
        
        let constraint = NSLayoutConstraint(item: self.rootView as Any, attribute: .leading, relatedBy: .equal, toItem: self.view1 as Any, attribute: .leading, multiplier: 1, constant: 0)
        
        for _ in 0..<10000 {
            queue.async {
                autoreleasepool {
                    CTVFLTransaction.begin()
                    
                    for _ in 0..<10000 {
                        CTVFLTransaction.addConstraint(constraint, enforces: true);
                    }
                    
                    CTVFLTransaction.commit()
                }
            }
        }
        
        queue.async(flags: .barrier) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 180)
    }
}

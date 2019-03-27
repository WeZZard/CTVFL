//
//  Benchmark.swift
//  CTVFL
//
//  Created on 2019/3/27.
//

import XCTest

@testable
import CTVFL

class Benchmark: XCTestCase {
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
    
    func testPerformanceOfCTVFL() {
        measure {
            for _ in 0..<10000 {
                withVFL(H: view1 - view2 - view3)
            }
        }
    }
    
    func testPerformanceOfVFL() {
        measure {
            for _ in 0..<10000 {
                _ = NSLayoutConstraint.constraints(
                    withVisualFormat: "[view1]-[view2]-[view3]",
                    options: [],
                    metrics: nil,
                    views: [
                        "view1": view1,
                        "view2": view2,
                        "view3": view3,
                    ]
                )
            }
        }
    }
}

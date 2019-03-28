//
//  Benchmark.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

import XCTest
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
    
    func testCTVFL() {
        measure {
            for _ in 0..<100000 {
                withVFL(H: view1 - view2)
            }
        }
    }
    
    func testVFL() {
        measure {
            for _ in 0..<100000 {
                _ = NSLayoutConstraint.constraints(withVisualFormat: "[view1]-[view2]", options: [], metrics: nil, views: ["view1": view1 as Any, "view2": view2 as Any])
            }
        }
    }
}

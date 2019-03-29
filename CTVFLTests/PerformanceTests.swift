//
//  PerformanceTests.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

import XCTest
@testable
import CTVFL

class PerformanceTests: XCTestCase {
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
    
    func testAnchor() {
        if #available(macOS 10.11, iOS 11.0, tvOS 11.0, *) {
            measure {
                for _ in 0..<100000 {
                    _ = view2.leadingAnchor.constraint(equalToSystemSpacingAfter: view1.trailingAnchor, multiplier: 1)
                }
            }
        }
    }
    
    func testDirectlyInit() {
        measure {
            for _ in 0..<100000 {
                _ = NSLayoutConstraint(item: view1 as Any, attribute: .trailing, relatedBy: .equal, toItem: view2 as Any, attribute: .leading, multiplier: 1, constant: 8)
            }
        }
    }
}

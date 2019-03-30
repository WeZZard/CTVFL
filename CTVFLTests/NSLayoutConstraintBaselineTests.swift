//
//  NSLayoutConstraintBaselineTests.swift
//  CTVFL
//
//  Created on 2019/3/30.
//

import XCTest

@testable
import CTVFL

class NSLayoutConstraintBaselineTests: XCTestCase {
    var rootView = CTVFLView()
    var view1 = CTVFLView()
    var view2 = CTVFLView()
    var view3 = CTVFLView()
    
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
    
    func testVFL_doesNotAlignToSuperview_withAnyAlignmentOptionsEnabled() {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "|[view]|", options: [.alignAllCenterY], metrics: nil, views: ["view": view1])
        
        XCTAssertEqual(constraints.count, 2)
    }
}

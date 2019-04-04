//
//  withVFL_UIKitTests.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


import XCTest

import CTVFL

class withVFL_UIKitTests: XCTestCase {
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
    
    func testWithVFL_withLayoutGuideAndViewWithSystemSpacing() {
        let h = withVFL(H: rootView.safeAreaLayoutGuide - view1)
        let v = withVFL(V: rootView.safeAreaLayoutGuide - view1)
        
        XCTAssertEqual(h.count, 1)
        XCTAssertEqual(h[0]._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(h[0]._ctvfl_secondAnchor, rootView.safeAreaLayoutGuide.leadingAnchor)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssertEqual(v[0]._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(v[0]._ctvfl_secondAnchor, rootView.safeAreaLayoutGuide.topAnchor)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    
    func testWithVFL_withViewAndLayoutGuideWithSystemSpacing() {
        let h = withVFL(H: view1 - rootView.safeAreaLayoutGuide)
        let v = withVFL(V: view1 - rootView.safeAreaLayoutGuide)
        
        XCTAssertEqual(h.count, 1)
        XCTAssertEqual(h[0]._ctvfl_firstAnchor, rootView.safeAreaLayoutGuide.trailingAnchor)
        XCTAssertEqual(h[0]._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssertEqual(v[0]._ctvfl_firstAnchor, rootView.safeAreaLayoutGuide.bottomAnchor)
        XCTAssertEqual(v[0]._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
}

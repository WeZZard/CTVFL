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
    
    func testCanCompile_withLayoutGuideAndViewWithSystemSpacing() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            let (_, h) = withVFL(H: rootView.safeAreaLayoutGuide - view1)
            let (_, v) = withVFL(V: rootView.safeAreaLayoutGuide - view1)
            
            XCTAssertEqual(h.count, 1)
            XCTAssertEqual(h[0].firstAnchor, rootView.safeAreaLayoutGuide.leadingAnchor)
            XCTAssertEqual(h[0].secondAnchor, view1.leadingAnchor)
            XCTAssertEqual(h[0].relation, .equal)
            XCTAssertEqual(h[0].constant, 8)
            XCTAssertEqual(h[0].multiplier, 1)
            XCTAssertEqual(h[0].priority, .required)
            
            XCTAssertEqual(v.count, 1)
            XCTAssertEqual(v[0].firstAnchor, rootView.safeAreaLayoutGuide.topAnchor)
            XCTAssertEqual(v[0].secondAnchor, view1.topAnchor)
            XCTAssertEqual(v[0].relation, .equal)
            XCTAssertEqual(v[0].constant, 8)
            XCTAssertEqual(v[0].multiplier, 1)
            XCTAssertEqual(v[0].priority, .required)
        }
    }
    
    
    func testCanCompile_withViewAndLayoutGuideWithSystemSpacing() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            let (_, h) = withVFL(H: view1 - rootView.safeAreaLayoutGuide)
            let (_, v) = withVFL(V: view1 - rootView.safeAreaLayoutGuide)
            
            XCTAssertEqual(h.count, 1)
            XCTAssertEqual(h[0].firstAnchor, view1.trailingAnchor)
            XCTAssertEqual(h[0].secondAnchor, rootView.safeAreaLayoutGuide.trailingAnchor)
            XCTAssertEqual(h[0].relation, .equal)
            XCTAssertEqual(h[0].constant, 8)
            XCTAssertEqual(h[0].multiplier, 1)
            XCTAssertEqual(h[0].priority, .required)
            
            XCTAssertEqual(v.count, 1)
            XCTAssertEqual(v[0].firstAnchor, view1.bottomAnchor)
            XCTAssertEqual(v[0].secondAnchor, rootView.safeAreaLayoutGuide.bottomAnchor)
            XCTAssertEqual(v[0].relation, .equal)
            XCTAssertEqual(v[0].constant, 8)
            XCTAssertEqual(v[0].multiplier, 1)
            XCTAssertEqual(v[0].priority, .required)
        }
    }
}

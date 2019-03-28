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
    
    func testCanCompile_withViewAndLayoutGuide() {
        if #available(iOS 11.0, *) {
            let h = withVFL(H: rootView.safeAreaLayoutGuide - view1)
            let v = withVFL(V: rootView.safeAreaLayoutGuide - view1)
            
            XCTAssertEqual(h.count, 1)
            XCTAssert(h[0].firstItem === rootView.safeAreaLayoutGuide)
            XCTAssertEqual(h[0].firstAttribute, .leading)
            XCTAssert(h[0].secondItem === view1)
            XCTAssertEqual(h[0].secondAttribute, .leading)
            XCTAssertEqual(h[0].relation, .equal)
            XCTAssertEqual(h[0].constant, 8)
            XCTAssertEqual(h[0].multiplier, 1)
            XCTAssertEqual(h[0].priority, .required)
            
            XCTAssertEqual(v.count, 1)
            XCTAssert(v[0].firstItem === rootView.safeAreaLayoutGuide)
            XCTAssertEqual(v[0].firstAttribute, .top)
            XCTAssert(v[0].secondItem === view1)
            XCTAssertEqual(v[0].secondAttribute, .top)
            XCTAssertEqual(v[0].relation, .equal)
            XCTAssertEqual(v[0].constant, 8)
            XCTAssertEqual(v[0].multiplier, 1)
            XCTAssertEqual(v[0].priority, .required)
        }
    }
}

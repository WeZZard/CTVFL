//
//  withVFLTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

import CTVFL

class withVFLTests: XCTestCase {
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
    
    func testFormatOptions_aligningThreeObjectWontDuplicate() {
        let h = withVFL(H: view1 | view2 | view3, options: .alignAllCenterY)
        let v = withVFL(V: view1 | view2 | view3, options: .alignAllCenterX)
        
        XCTAssertEqual(h.count, 4)
        
        XCTAssertEqual(v.count, 4)
    }
    
    func testFormatOptions_canAlign() {
        let h = withVFL(H: view1 | view2, options: .alignAllCenterY)
        let v = withVFL(V: view1 | view2, options: .alignAllCenterX)
        
        XCTAssertEqual(h.count, 2)
        let hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        let vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_rightLeaningSyntaxTree() {
        let view2_3 = view2 - view3
        let view1_3 = view1 - view2_3
        let h = withVFL(H: |view1_3|)
        let v = withVFL(V: |view1_3|)
        
        NSLog("view1: %@", view1)
        NSLog("view2: %@", view2)
        NSLog("view3: %@", view3)
        
        XCTAssertEqual(h.count, 4)
        var hc = h[0]
        XCTAssert(hc.firstItem === view3)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view2)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[2]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view3)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[3]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 4)
        var vc = v[0]
        XCTAssert(vc.firstItem === view3)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view2)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[2]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view3)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[3]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicatedView_ofEqualSemantic() {
        let h = withVFL(H: view1.where(200))
        let v = withVFL(V: view1.where(200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicatedView_ofEqualSemantic_withPriority() {
        let h = withVFL(H: view1.where(200 ~ 750))
        let v = withVFL(V: view1.where(200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofLessThanOrEqual() {
        let h = withVFL(H: view1.where(<=200))
        let v = withVFL(V: view1.where(<=200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicatedView_ofLessThanOrEqual_withPriority() {
        let h = withVFL(H: view1.where(<=200 ~ 750))
        let v = withVFL(V: view1.where(<=200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofGreaterThanOrEqual() {
        let h = withVFL(H: view1.where(>=200))
        let v = withVFL(V: view1.where(>=200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicatedView_ofGreaterThanOrEqual_withPriority() {
        let h = withVFL(H: view1.where(>=200 ~ 750))
        let v = withVFL(V: view1.where(>=200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofEqual() {
        let h = withVFL(H: view1.where(==200))
        let v = withVFL(V: view1.where(==200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicatedView_ofEqual_withPriority() {
        let h = withVFL(H: view1.where(==200 ~ 750))
        let v = withVFL(V: view1.where(==200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofEqualView() {
        let h = withVFL(H: view1.where(==view2))
        let v = withVFL(V: view1.where(==view2))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .width)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .height)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_multiplePredicatedView() {
        let h = withVFL(H: view1.where(>=200, <=800))
        let v = withVFL(V: view1.where(>=200, <=800))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 800)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 800)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_multiplePredicatedView_withPriority() {
        let h = withVFL(H: view1.where(>=200 ~ 250, <=800 ~ 750))
        let v = withVFL(V: view1.where(>=200 ~ 250, <=800 ~ 750))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 250))
        
        hc = h[1]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 800)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 250))
        
        vc = v[1]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 800)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_doubleEdgedView() {
        let h = withVFL(H: |view1|)
        let v = withVFL(V: |view1|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_doubleEdgedView_withPredicate() {
        let h = withVFL(H: |view1.where(200)|)
        let v = withVFL(V: |view1.where(200)|)
        
        XCTAssertEqual(h.count, 3)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[2]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 3)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[2]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingEdgedView() {
        let h = withVFL(H: |view1)
        let v = withVFL(V: |view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingEdgedView_withPredicate() {
        let h = withVFL(H: |view1.where(200))
        let v = withVFL(V: |view1.where(200))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingEdgedView() {
        let h = withVFL(H: view1|)
        let v = withVFL(V: view1|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingEdgedView_withPredicate() {
        let h = withVFL(H: view1.where(200)|)
        let v = withVFL(V: view1.where(200)|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedTrailingEdgedView() {
        let h = withVFL(H: |-view1|)
        let v = withVFL(V: |-view1|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingEdgedTrailingSpaceEdgedView() {
        let h = withVFL(H: |view1-|)
        let v = withVFL(V: |view1-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView() {
        let h = withVFL(H: |-view1)
        let v = withVFL(V: |-view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withAdjacentView() {
        let h = withVFL(H: |-view1 | view2)
        let v = withVFL(V: |-view1 | view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withSpacedView() {
        let h = withVFL(H: |-view1 - view2)
        let v = withVFL(V: |-view1 - view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withSpecificNumberSpacedView() {
        let h = withVFL(H: |-view1 - 4 - view2)
        let v = withVFL(V: |-view1 - 4 - view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withPredicateSpacedView() {
        let h = withVFL(H: |-view1 - (>=200) - view2)
        let v = withVFL(V: |-view1 - (>=200) - view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView() {
        let h = withVFL(H: view1-|)
        let v = withVFL(V: view1-|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withAdjacentView() {
        let h = withVFL(H: view1 | view2-|)
        let v = withVFL(V: view1 | view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view2)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view2)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withSpacedView() {
        let h = withVFL(H: view1 - view2-|)
        let v = withVFL(V: view1 - view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view2)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view2)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withSpecificNumberSpacedView() {
        let h = withVFL(H: view1 - 4 - view2-|)
        let v = withVFL(V: view1 - 4 - view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view2)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view2)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withPredicateSpacedView() {
        let h = withVFL(H: view1 - (>=200) - view2-|)
        let v = withVFL(V: view1 - (>=200) - view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view2)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view2)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_specificNumberLeadingSpaceEdgedView() {
        let h = withVFL(H: |-4 - view1)
        let v = withVFL(V: |-4 - view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_specificNumberTrailingSpaceEdgedView() {
        let h = withVFL(H: view1 - 4-|)
        let v = withVFL(V: view1 - 4-|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicateLeadingSpaceEdgedView() {
        let h = withVFL(H: |-(>=4) - view1)
        let v = withVFL(V: |-(>=4) - view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicateTrailingSpaceEdgedView() {
        let h = withVFL(H: view1 - (>=4)-|)
        let v = withVFL(V: view1 - (>=4)-|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withPredicate() {
        let h = withVFL(H: |-view1.where(200))
        let v = withVFL(V: |-view1.where(200))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === rootView)
        XCTAssertEqual(hc.secondAttribute, .leading)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === rootView)
        XCTAssertEqual(vc.secondAttribute, .top)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withPredicate() {
        let h = withVFL(H: view1.where(200)-|)
        let v = withVFL(V: view1.where(200)-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view1)
        XCTAssertEqual(hc.firstAttribute, .width)
        XCTAssert(hc.secondItem === nil)
        XCTAssertEqual(hc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === rootView)
        XCTAssertEqual(hc.firstAttribute, .trailing)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view1)
        XCTAssertEqual(vc.firstAttribute, .height)
        XCTAssert(vc.secondItem === nil)
        XCTAssertEqual(vc.secondAttribute, .notAnAttribute)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === rootView)
        XCTAssertEqual(vc.firstAttribute, .bottom)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_adjacentViews() {
        let h = withVFL(H: view1 | view2)
        let v = withVFL(V: view1 | view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_adjacentViews_ofMultipleTimes() {
        let h = withVFL(H: view1 | view2 | view3)
        let v = withVFL(V: view1 | view2 | view3)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssert(hc.firstItem === view3)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view2)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssert(vc.firstItem === view3)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view2)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_spacedViews() {
        let h = withVFL(H: view1 - view2)
        let v = withVFL(V: view1 - view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    /*
    func testCanCompile_spacedViews_ofMultipleTimes() {
        let h = withVFL(H: view1 - view2 - view3)
        let v = withVFL(V: view1 - view2 - view3)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssert(hc.firstItem === view3)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view2)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        XCTAssert(vc.firstItem === view3)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view2)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }*/
    
    func testCanCompile_specificNumberSpacedViews() {
        let h = withVFL(H: view1 - 2 - view2)
        let v = withVFL(V: view1 - 2 - view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 2)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 2)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testCanCompile_predicateSpacedViews() {
        let h = withVFL(H: view1 - (<=200) - view2)
        let v = withVFL(V: view1 - (<=200) - view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssert(hc.firstItem === view2)
        XCTAssertEqual(hc.firstAttribute, .leading)
        XCTAssert(hc.secondItem === view1)
        XCTAssertEqual(hc.secondAttribute, .trailing)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssert(vc.firstItem === view2)
        XCTAssertEqual(vc.firstAttribute, .top)
        XCTAssert(vc.secondItem === view1)
        XCTAssertEqual(vc.secondAttribute, .bottom)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    // Swift compiler currently cannot complete type-checking in a
    // reasonable time with following expressions.
    //
    // > The compiler is unable to type-check this expression in
    // > reasonable time; try breaking up the expression into distinct
    // > sub-expressions.
    //
    
    /*
    func testCanCompile_specificNumberSpacedViews_ofMultipleTimes() {
        withVFL(H: view1 - 2 - view2 - 4 - view3)
        withVFL(V: view1 - 2 - view2 - 4 - view3)
    }
    
    func testCanCompile_mixedSpacedViews1_ofMultipleTimes() {
        withVFL(H: view1 - (<=200) - view2 - 4 - view3)
        withVFL(V: view1 - (<=200) - view2 - 4 - view3)
    }
    
    func testCanCompile_mixedSpacedViews2_ofMultipleTimes() {
        withVFL(H: view1 - 4 - view2 - (<=200) - view3)
        withVFL(V: view1 - 4 - view2 - (<=200) - view3)
    }*/
}

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
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_rightLeaningSyntaxTree() {
        let view2_3 = view2 - view3
        let view1_3 = view1 - view2_3
        let h = withVFL(H: |view1_3|)
        let v = withVFL(V: |view1_3|)
        
        NSLog("view1: %@", view1)
        NSLog("view2: %@", view2)
        NSLog("view3: %@", view3)
        
        XCTAssertEqual(h.count, 4)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view3.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view2.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[2]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view3.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[3]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 4)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view3.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view2.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[2]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view3.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[3]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicatedView_ofEqualSemantic() {
        let h = withVFL(H: view1.where(200))
        let v = withVFL(V: view1.where(200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicatedView_ofEqualSemantic_withPriority() {
        let h = withVFL(H: view1.where(200 ~ 750))
        let v = withVFL(V: view1.where(200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testWithVFL_predicatedView_ofLessThanOrEqual() {
        let h = withVFL(H: view1.where(<=200))
        let v = withVFL(V: view1.where(<=200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicatedView_ofLessThanOrEqual_withPriority() {
        let h = withVFL(H: view1.where(<=200 ~ 750))
        let v = withVFL(V: view1.where(<=200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testWithVFL_predicatedView_ofGreaterThanOrEqual() {
        let h = withVFL(H: view1.where(>=200))
        let v = withVFL(V: view1.where(>=200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicatedView_ofGreaterThanOrEqual_withPriority() {
        let h = withVFL(H: view1.where(>=200 ~ 750))
        let v = withVFL(V: view1.where(>=200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testWithVFL_predicatedView_ofEqual() {
        let h = withVFL(H: view1.where(==200))
        let v = withVFL(V: view1.where(==200))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicatedView_ofEqual_withPriority() {
        let h = withVFL(H: view1.where(==200 ~ 750))
        let v = withVFL(V: view1.where(==200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testWithVFL_predicatedView_ofEqualView() {
        let h = withVFL(H: view1.where(==view2))
        let v = withVFL(V: view1.where(==view2))
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.widthAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.heightAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_multiplePredicatedView() {
        let h = withVFL(H: view1.where(>=200, <=800))
        let v = withVFL(V: view1.where(>=200, <=800))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 800)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 800)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_multiplePredicatedView_withPriority() {
        let h = withVFL(H: view1.where(>=200 ~ 250, <=800 ~ 750))
        let v = withVFL(V: view1.where(>=200 ~ 250, <=800 ~ 750))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 250))
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 800)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 250))
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .lessThanOrEqual)
        XCTAssertEqual(vc.constant, 800)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, CTVFLPriority(rawValue: 750))
    }
    
    func testWithVFL_doubleEdgedView() {
        let h = withVFL(H: |view1|)
        let v = withVFL(V: |view1|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_doubleEdgedView_withPredicate() {
        let h = withVFL(H: |view1.where(200)|)
        let v = withVFL(V: |view1.where(200)|)
        
        XCTAssertEqual(h.count, 3)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[2]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 3)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[2]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingEdgedView() {
        let h = withVFL(H: |view1)
        let v = withVFL(V: |view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingEdgedView_withPredicate() {
        let h = withVFL(H: |view1.where(200))
        let v = withVFL(V: |view1.where(200))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingEdgedView() {
        let h = withVFL(H: view1|)
        let v = withVFL(V: view1|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingEdgedView_withPredicate() {
        let h = withVFL(H: view1.where(200)|)
        let v = withVFL(V: view1.where(200)|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingSpaceEdgedTrailingEdgedView() {
        let h = withVFL(H: |-view1|)
        let v = withVFL(V: |-view1|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingEdgedTrailingSpaceEdgedView() {
        let h = withVFL(H: |view1-|)
        let v = withVFL(V: |view1-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingSpaceEdgedView() {
        let h = withVFL(H: |-view1)
        let v = withVFL(V: |-view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingSpaceEdgedView_withAdjacentView() {
        let h = withVFL(H: |-view1 | view2)
        let v = withVFL(V: |-view1 | view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingSpaceEdgedView_withSpacedView() {
        let h = withVFL(H: |-view1 - view2)
        let v = withVFL(V: |-view1 - view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingSpaceEdgedView_withSpecificNumberSpacedView() {
        let h = withVFL(H: |-view1 - 4 - view2)
        let v = withVFL(V: |-view1 - 4 - view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingSpaceEdgedView_withPredicateSpacedView() {
        let h = withVFL(H: |-view1 - (>=200) - view2)
        let v = withVFL(V: |-view1 - (>=200) - view2)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingSpaceEdgedView() {
        let h = withVFL(H: view1-|)
        let v = withVFL(V: view1-|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingSpaceEdgedView_withAdjacentView() {
        let h = withVFL(H: view1 | view2-|)
        let v = withVFL(V: view1 | view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view2.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view2.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingSpaceEdgedView_withSpacedView() {
        let h = withVFL(H: view1 - view2-|)
        let v = withVFL(V: view1 - view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view2.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view2.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingSpaceEdgedView_withSpecificNumberSpacedView() {
        let h = withVFL(H: view1 - 4 - view2-|)
        let v = withVFL(V: view1 - 4 - view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view2.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view2.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingSpaceEdgedView_withPredicateSpacedView() {
        let h = withVFL(H: view1 - (>=200) - view2-|)
        let v = withVFL(V: view1 - (>=200) - view2-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view2.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view2.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_specificNumberLeadingSpaceEdgedView() {
        let h = withVFL(H: |-4 - view1)
        let v = withVFL(V: |-4 - view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_specificNumberTrailingSpaceEdgedView() {
        let h = withVFL(H: view1 - 4-|)
        let v = withVFL(V: view1 - 4-|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicateLeadingSpaceEdgedView() {
        let h = withVFL(H: |-(>=4) - view1)
        let v = withVFL(V: |-(>=4) - view1)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicateTrailingSpaceEdgedView() {
        let h = withVFL(H: view1 - (>=4)-|)
        let v = withVFL(V: view1 - (>=4)-|)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .greaterThanOrEqual)
        XCTAssertEqual(hc.constant, 4)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .greaterThanOrEqual)
        XCTAssertEqual(vc.constant, 4)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_leadingSpaceEdgedView_withPredicate() {
        let h = withVFL(H: |-view1.where(200))
        let v = withVFL(V: |-view1.where(200))
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, rootView.leadingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, rootView.topAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_trailingSpaceEdgedView_withPredicate() {
        let h = withVFL(H: view1.where(200)-|)
        let v = withVFL(V: view1.where(200)-|)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view1.widthAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, rootView.trailingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view1.heightAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 200)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, rootView.bottomAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_adjacentViews() {
        let h = withVFL(H: view1 | view2)
        let v = withVFL(V: view1 | view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_adjacentViews_ofMultipleTimes() {
        let h = withVFL(H: view1 | view2 | view3)
        let v = withVFL(V: view1 | view2 | view3)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view3.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view2.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 0)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        vc = v[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view3.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view2.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 0)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_spacedViews() {
        let h = withVFL(H: view1 - view2)
        let v = withVFL(V: view1 - view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    // The following test case conlicts with the function
    // `func - (_: Self, _: Self) -> Self where Self: Numeric`, which is
    // a bug of the compiler
    //
    
    func testWithVFL_spacedViews_ofMultipleTimes() {
        let a = view1 - view2 - view3
        let h = withVFL(H: view1 - view2 - view3)
        let v = withVFL(V: view1 - view2 - view3)
        
        XCTAssertEqual(h.count, 2)
        var hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view3.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view2.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 8)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 2)
        var vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
        
        hc = h[1]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view3.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view2.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 8)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_specificNumberSpacedViews() {
        let h = withVFL(H: view1 - 2 - view2)
        let v = withVFL(V: view1 - 2 - view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .equal)
        XCTAssertEqual(hc.constant, 2)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
        XCTAssertEqual(vc.relation, .equal)
        XCTAssertEqual(vc.constant, 2)
        XCTAssertEqual(vc.multiplier, 1)
        XCTAssertEqual(vc.priority, .required)
    }
    
    func testWithVFL_predicateSpacedViews() {
        let h = withVFL(H: view1 - (<=200) - view2)
        let v = withVFL(V: view1 - (<=200) - view2)
        
        XCTAssertEqual(h.count, 1)
        let hc = h[0]
        XCTAssertEqual(hc._ctvfl_firstAnchor, view2.leadingAnchor)
        XCTAssertEqual(hc._ctvfl_secondAnchor, view1.trailingAnchor)
        XCTAssertEqual(hc.relation, .lessThanOrEqual)
        XCTAssertEqual(hc.constant, 200)
        XCTAssertEqual(hc.multiplier, 1)
        XCTAssertEqual(hc.priority, .required)
        
        XCTAssertEqual(v.count, 1)
        let vc = v[0]
        XCTAssertEqual(vc._ctvfl_firstAnchor, view2.topAnchor)
        XCTAssertEqual(vc._ctvfl_secondAnchor, view1.bottomAnchor)
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
    func testWithVFL_specificNumberSpacedViews_ofMultipleTimes() {
        withVFL(H: view1 - 2 - view2 - 4 - view3)
        withVFL(V: view1 - 2 - view2 - 4 - view3)
    }
    
    func testWithVFL_mixedSpacedViews1_ofMultipleTimes() {
        withVFL(H: view1 - (<=200) - view2 - 4 - view3)
        withVFL(V: view1 - (<=200) - view2 - 4 - view3)
    }
    
    func testWithVFL_mixedSpacedViews2_ofMultipleTimes() {
        withVFL(H: view1 - 4 - view2 - (<=200) - view3)
        withVFL(V: view1 - 4 - view2 - (<=200) - view3)
    }*/
}

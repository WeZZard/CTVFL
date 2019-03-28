//
//  withVFLTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

import CTVFL

extension NSLayoutAttribute: CustomStringConvertible {
    public var description: String {
        switch self {
        case .bottom: return "Bottom"
        case .bottomMargin: return "BottomMargin"
        case .centerX: return "CenterX"
        case .centerXWithinMargins: return "CenterXWithMargins"
        case .centerY: return "CenterY"
        case .centerYWithinMargins: return "CenterYWithMargins"
        case .firstBaseline: return "FirstBaseline"
        case .height: return "Height"
        case .lastBaseline: return "LastBaseline"
        case .leading: return "Leading"
        case .leadingMargin: return "LeadingMargin"
        case .left: return "Left"
        case .leftMargin: return "LeftMargin"
        case .notAnAttribute: return "NotAnAttribute"
        case .right: return "Right"
        case .rightMargin: return "RightMargin"
        case .top: return "Top"
        case .topMargin: return "TopMargin"
        case .trailing: return "Trailing"
        case .trailingMargin: return "TrailingMargin"
        case .width: return "Width"
        }
    }
}

class withVFLTests: XCTestCase {
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
    
    /*
    func testCanCompile_withViewAndLayoutGuide() {
        let h = withVFL(H: view1.safeAreaLayoutGuide - view1)
        let v = withVFL(V: view1.safeAreaLayoutGuide - view1)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1.safeAreaLayoutGuide)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1.safeAreaLayoutGuide)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }*/
    
    func testCanCompile_predicatedView_ofEqualSemantic() {
        let h = withVFL(H: view1.where(200))
        let v = withVFL(V: view1.where(200))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_predicatedView_ofEqualSemantic_withPriority() {
        let h = withVFL(H: view1.where(200 ~ 750))
        let v = withVFL(V: view1.where(200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofLessThanOrEqual() {
        let h = withVFL(H: view1.where(<=200))
        let v = withVFL(V: view1.where(<=200))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .lessThanOrEqual)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .lessThanOrEqual)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_predicatedView_ofLessThanOrEqual_withPriority() {
        let h = withVFL(H: view1.where(<=200 ~ 750))
        let v = withVFL(V: view1.where(<=200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .lessThanOrEqual)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .lessThanOrEqual)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofGreaterThanOrEqual() {
        let h = withVFL(H: view1.where(>=200))
        let v = withVFL(V: view1.where(>=200))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_predicatedView_ofGreaterThanOrEqual_withPriority() {
        let h = withVFL(H: view1.where(>=200 ~ 750))
        let v = withVFL(V: view1.where(>=200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofEqual() {
        let h = withVFL(H: view1.where(==200))
        let v = withVFL(V: view1.where(==200))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_predicatedView_ofEqual_withPriority() {
        let h = withVFL(H: view1.where(==200 ~ 750))
        let v = withVFL(V: view1.where(==200 ~ 750))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_predicatedView_ofEqualView() {
        let h = withVFL(H: view1.where(==view2))
        let v = withVFL(V: view1.where(==view2))
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === view2)
        XCTAssertEqual(h[0].secondAttribute, .width)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 0)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === view2)
        XCTAssertEqual(v[0].secondAttribute, .height)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 0)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_multiplePredicatedView() {
        let h = withVFL(H: view1.where(>=200, <=800))
        let v = withVFL(V: view1.where(>=200, <=800))
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .width)
        XCTAssert(h[1].secondItem === nil)
        XCTAssertEqual(h[1].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[1].relation, .lessThanOrEqual)
        XCTAssertEqual(h[1].constant, 800)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .height)
        XCTAssert(v[1].secondItem === nil)
        XCTAssertEqual(v[1].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[1].relation, .lessThanOrEqual)
        XCTAssertEqual(v[1].constant, 800)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_multiplePredicatedView_withPriority() {
        let h = withVFL(H: view1.where(>=200 ~ 250, <=800 ~ 750))
        let v = withVFL(V: view1.where(>=200 ~ 250, <=800 ~ 750))
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, CTVFLPriority(rawValue: 250))
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .width)
        XCTAssert(h[1].secondItem === nil)
        XCTAssertEqual(h[1].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[1].relation, .lessThanOrEqual)
        XCTAssertEqual(h[1].constant, 800)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, CTVFLPriority(rawValue: 750))
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, CTVFLPriority(rawValue: 250))
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .height)
        XCTAssert(v[1].secondItem === nil)
        XCTAssertEqual(v[1].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[1].relation, .lessThanOrEqual)
        XCTAssertEqual(v[1].constant, 800)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, CTVFLPriority(rawValue: 750))
    }
    
    func testCanCompile_doubleEdgedView() {
        let h = withVFL(H: |view1|)
        let v = withVFL(V: |view1|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 0)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === rootView)
        XCTAssertEqual(h[1].firstAttribute, .leading)
        XCTAssert(h[1].secondItem === view1)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 0)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === rootView)
        XCTAssertEqual(v[1].firstAttribute, .top)
        XCTAssert(v[1].secondItem === view1)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_doubleEdgedView_withPredicate() {
        let h = withVFL(H: |view1.where(200)|)
        let v = withVFL(V: |view1.where(200)|)
        
        XCTAssertEqual(h.count, 3)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === rootView)
        XCTAssertEqual(h[1].secondAttribute, .trailing)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssert(h[2].firstItem === rootView)
        XCTAssertEqual(h[2].firstAttribute, .leading)
        XCTAssert(h[2].secondItem === view1)
        XCTAssertEqual(h[2].secondAttribute, .leading)
        XCTAssertEqual(h[2].relation, .equal)
        XCTAssertEqual(h[2].constant, 0)
        XCTAssertEqual(h[2].multiplier, 1)
        XCTAssertEqual(h[2].priority, .required)
        
        XCTAssertEqual(v.count, 3)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === rootView)
        XCTAssertEqual(v[1].secondAttribute, .bottom)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
        
        XCTAssert(v[2].firstItem === rootView)
        XCTAssertEqual(v[2].firstAttribute, .top)
        XCTAssert(v[2].secondItem === view1)
        XCTAssertEqual(v[2].secondAttribute, .top)
        XCTAssertEqual(v[2].relation, .equal)
        XCTAssertEqual(v[2].constant, 0)
        XCTAssertEqual(v[2].multiplier, 1)
        XCTAssertEqual(v[2].priority, .required)
    }
    
    func testCanCompile_leadingEdgedView() {
        let h = withVFL(H: |view1)
        let v = withVFL(V: |view1)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 0)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 0)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_leadingEdgedView_withPredicate() {
        let h = withVFL(H: |view1.where(200))
        let v = withVFL(V: |view1.where(200))
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === rootView)
        XCTAssertEqual(h[1].firstAttribute, .leading)
        XCTAssert(h[1].secondItem === view1)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === rootView)
        XCTAssertEqual(v[1].firstAttribute, .top)
        XCTAssert(v[1].secondItem === view1)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_trailingEdgedView() {
        let h = withVFL(H: view1|)
        let v = withVFL(V: view1|)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 0)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 0)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_trailingEdgedView_withPredicate() {
        let h = withVFL(H: view1.where(200)|)
        let v = withVFL(V: view1.where(200)|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === rootView)
        XCTAssertEqual(h[1].secondAttribute, .trailing)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === rootView)
        XCTAssertEqual(v[1].secondAttribute, .bottom)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedTrailingEdgedView() {
        let h = withVFL(H: |-view1|)
        let v = withVFL(V: |-view1|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 0)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === rootView)
        XCTAssertEqual(h[1].firstAttribute, .leading)
        XCTAssert(h[1].secondItem === view1)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 8)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 0)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === rootView)
        XCTAssertEqual(v[1].firstAttribute, .top)
        XCTAssert(v[1].secondItem === view1)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 8)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_leadingEdgedTrailingSpaceEdgedView() {
        let h = withVFL(H: |view1-|)
        let v = withVFL(V: |view1-|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === rootView)
        XCTAssertEqual(h[1].firstAttribute, .leading)
        XCTAssert(h[1].secondItem === view1)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === rootView)
        XCTAssertEqual(v[1].firstAttribute, .top)
        XCTAssert(v[1].secondItem === view1)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView() {
        let h = withVFL(H: |-view1)
        let v = withVFL(V: |-view1)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withAdjacentView() {
        let h = withVFL(H: |-view1 | view2)
        let v = withVFL(V: |-view1 | view2)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withSpacedView() {
        let h = withVFL(H: |-view1 - view2)
        let v = withVFL(V: |-view1 - view2)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 8)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 8)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withSpecificNumberSpacedView() {
        let h = withVFL(H: |-view1 - 4 - view2)
        let v = withVFL(V: |-view1 - 4 - view2)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 4)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 4)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withPredicateSpacedView() {
        let h = withVFL(H: |-view1 - (>=200) - view2)
        let v = withVFL(V: |-view1 - (>=200) - view2)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[1].constant, 200)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[1].constant, 200)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView() {
        let h = withVFL(H: view1-|)
        let v = withVFL(V: view1-|)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withAdjacentView() {
        let h = withVFL(H: view1 | view2-|)
        let v = withVFL(V: view1 | view2-|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view2)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view2)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withSpacedView() {
        let h = withVFL(H: view1 - view2-|)
        let v = withVFL(V: view1 - view2-|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view2)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 8)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view2)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 8)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withSpecificNumberSpacedView() {
        let h = withVFL(H: view1 - 4 - view2-|)
        let v = withVFL(V: view1 - 4 - view2-|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view2)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 4)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view2)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 4)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withPredicateSpacedView() {
        let h = withVFL(H: view1 - (>=200) - view2-|)
        let v = withVFL(V: view1 - (>=200) - view2-|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view2)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view2)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[1].constant, 200)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view2)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view2)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[1].constant, 200)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_specificNumberLeadingSpaceEdgedView() {
        let h = withVFL(H: |-4 - view1)
        let v = withVFL(V: |-4 - view1)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 4)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 4)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_specificNumberTrailingSpaceEdgedView() {
        let h = withVFL(H: view1 - 4-|)
        let v = withVFL(V: view1 - 4-|)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 4)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 4)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_predicateLeadingSpaceEdgedView() {
        let h = withVFL(H: |-(>=4) - view1)
        let v = withVFL(V: |-(>=4) - view1)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === rootView)
        XCTAssertEqual(h[0].firstAttribute, .leading)
        XCTAssert(h[0].secondItem === view1)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[0].constant, 4)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === rootView)
        XCTAssertEqual(v[0].firstAttribute, .top)
        XCTAssert(v[0].secondItem === view1)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[0].constant, 4)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_predicateTrailingSpaceEdgedView() {
        let h = withVFL(H: view1 - (>=4)-|)
        let v = withVFL(V: view1 - (>=4)-|)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === rootView)
        XCTAssertEqual(h[0].secondAttribute, .trailing)
        XCTAssertEqual(h[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(h[0].constant, 4)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === rootView)
        XCTAssertEqual(v[0].secondAttribute, .bottom)
        XCTAssertEqual(v[0].relation, .greaterThanOrEqual)
        XCTAssertEqual(v[0].constant, 4)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withPredicate() {
        let h = withVFL(H: |-view1.where(200))
        let v = withVFL(V: |-view1.where(200))
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === rootView)
        XCTAssertEqual(h[1].firstAttribute, .leading)
        XCTAssert(h[1].secondItem === view1)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 8)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === rootView)
        XCTAssertEqual(v[1].firstAttribute, .top)
        XCTAssert(v[1].secondItem === view1)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 8)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withPredicate() {
        let h = withVFL(H: view1.where(200)-|)
        let v = withVFL(V: view1.where(200)-|)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .width)
        XCTAssert(h[0].secondItem === nil)
        XCTAssertEqual(h[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view1)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === rootView)
        XCTAssertEqual(h[1].secondAttribute, .trailing)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 8)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .height)
        XCTAssert(v[0].secondItem === nil)
        XCTAssertEqual(v[0].secondAttribute, .notAnAttribute)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view1)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === rootView)
        XCTAssertEqual(v[1].secondAttribute, .bottom)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 8)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_adjacentViews() {
        let h = withVFL(H: view1 | view2)
        let v = withVFL(V: view1 | view2)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === view2)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 0)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === view2)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 0)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_adjacentViews_ofMultipleTimes() {
        let h = withVFL(H: view1 | view2 | view3)
        let v = withVFL(V: view1 | view2 | view3)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === view2)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 0)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view2)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view3)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 0)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === view2)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 0)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view2)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view3)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 0)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_spacedViews() {
        let h = withVFL(H: view1 - view2)
        let v = withVFL(V: view1 - view2)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === view2)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === view2)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_spacedViews_ofMultipleTimes() {
        let h = withVFL(H: view1 - view2 - view3)
        let v = withVFL(V: view1 - view2 - view3)
        
        XCTAssertEqual(h.count, 2)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === view2)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 8)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssert(h[1].firstItem === view2)
        XCTAssertEqual(h[1].firstAttribute, .trailing)
        XCTAssert(h[1].secondItem === view3)
        XCTAssertEqual(h[1].secondAttribute, .leading)
        XCTAssertEqual(h[1].relation, .equal)
        XCTAssertEqual(h[1].constant, 8)
        XCTAssertEqual(h[1].multiplier, 1)
        XCTAssertEqual(h[1].priority, .required)
        
        XCTAssertEqual(v.count, 2)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === view2)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 8)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
        
        XCTAssert(v[1].firstItem === view2)
        XCTAssertEqual(v[1].firstAttribute, .bottom)
        XCTAssert(v[1].secondItem === view3)
        XCTAssertEqual(v[1].secondAttribute, .top)
        XCTAssertEqual(v[1].relation, .equal)
        XCTAssertEqual(v[1].constant, 8)
        XCTAssertEqual(v[1].multiplier, 1)
        XCTAssertEqual(v[1].priority, .required)
    }
    
    func testCanCompile_specificNumberSpacedViews() {
        let h = withVFL(H: view1 - 2 - view2)
        let v = withVFL(V: view1 - 2 - view2)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === view2)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .equal)
        XCTAssertEqual(h[0].constant, 2)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === view2)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .equal)
        XCTAssertEqual(v[0].constant, 2)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
    }
    
    func testCanCompile_predicateSpacedViews() {
        let h = withVFL(H: view1 - (<=200) - view2)
        let v = withVFL(V: view1 - (<=200) - view2)
        
        XCTAssertEqual(h.count, 1)
        XCTAssert(h[0].firstItem === view1)
        XCTAssertEqual(h[0].firstAttribute, .trailing)
        XCTAssert(h[0].secondItem === view2)
        XCTAssertEqual(h[0].secondAttribute, .leading)
        XCTAssertEqual(h[0].relation, .lessThanOrEqual)
        XCTAssertEqual(h[0].constant, 200)
        XCTAssertEqual(h[0].multiplier, 1)
        XCTAssertEqual(h[0].priority, .required)
        
        XCTAssertEqual(v.count, 1)
        XCTAssert(v[0].firstItem === view1)
        XCTAssertEqual(v[0].firstAttribute, .bottom)
        XCTAssert(v[0].secondItem === view2)
        XCTAssertEqual(v[0].secondAttribute, .top)
        XCTAssertEqual(v[0].relation, .lessThanOrEqual)
        XCTAssertEqual(v[0].constant, 200)
        XCTAssertEqual(v[0].multiplier, 1)
        XCTAssertEqual(v[0].priority, .required)
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

//
//  CTVFLTests.swift
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

class CTVFLTests: XCTestCase {
    var rootView: View!
    var view1: View!
    var view2: View!
    var view3: View!
    
    override func setUp() {
        super.setUp()
        rootView = View()
        
        view1 = View()
        view2 = View()
        view3 = View()
        
        rootView.addSubview(view1)
        rootView.addSubview(view2)
        rootView.addSubview(view3)
    }
    
    func testCanCompile_predicatedView_ofEqualSemantic() {
        withVFL(H: view1.where(200))
        withVFL(V: view1.where(200))
    }
    
    func testCanCompile_predicatedView_ofEqualSemantic_withPriority() {
        withVFL(H: view1.where(200 ~ 750))
        withVFL(V: view1.where(200 ~ 750))
    }
    
    func testCanCompile_predicatedView_ofLessThanOrEqual() {
        withVFL(H: view1.where(<=200))
        withVFL(V: view1.where(<=200))
    }
    
    func testCanCompile_predicatedView_ofLessThanOrEqual_withPriority() {
        withVFL(H: view1.where(<=200 ~ 750))
        withVFL(V: view1.where(<=200 ~ 750))
    }
    
    func testCanCompile_predicatedView_ofGreaterThanOrEqual() {
        withVFL(H: view1.where(>=200))
        withVFL(V: view1.where(>=200))
    }
    
    func testCanCompile_predicatedView_ofGreaterThanOrEqual_withPriority() {
        withVFL(H: view1.where(>=200 ~ 750))
        withVFL(V: view1.where(>=200 ~ 750))
    }
    
    func testCanCompile_predicatedView_ofEqual() {
        withVFL(H: view1.where(==200))
        withVFL(V: view1.where(==200))
    }
    
    func testCanCompile_predicatedView_ofEqual_withPriority() {
        withVFL(H: view1.where(==200 ~ 750))
        withVFL(V: view1.where(==200 ~ 750))
    }
    
    func testCanCompile_predicatedView_ofEqualView() {
        withVFL(H: view1.where(==view2))
        withVFL(V: view1.where(==view2))
    }
    
    func testCanCompile_multiplePredicatedView() {
        withVFL(H: view1.where(>=200, <=800))
        withVFL(V: view1.where(>=200, <=800))
    }
    
    func testCanCompile_multiplePredicatedView_withPriority() {
        withVFL(H: view1.where(>=200 ~ 250, <=800 ~ 750))
        withVFL(V: view1.where(>=200 ~ 250, <=800 ~ 750))
    }
    
    func testCanCompile_doubleEdgedView() {
        withVFL(H: |view1|)
        withVFL(V: |view1|)
    }
    
    func testCanCompile_doubleEdgedView_withPredicate() {
        withVFL(H: |view1.where(200)|)
        withVFL(V: |view1.where(200)|)
    }
    
    func testCanCompile_leadingEdgedView() {
        withVFL(H: |view1)
        withVFL(V: |view1)
    }
    
    func testCanCompile_leadingEdgedView_withPredicate() {
        withVFL(H: |view1.where(200))
        withVFL(V: |view1.where(200))
    }
    
    func testCanCompile_trailingEdgedView() {
        withVFL(H: view1|)
        withVFL(V: view1|)
    }
    
    func testCanCompile_trailingEdgedView_withPredicate() {
        withVFL(H: view1.where(200)|)
        withVFL(V: view1.where(200)|)
    }
    
    func testCanCompile_leadingSpaceEdgedTrailingEdgedView() {
        withVFL(H: |-view1|)
        withVFL(V: |-view1|)
    }
    
    func testCanCompile_leadingEdgedTrailingSpaceEdgedView() {
        withVFL(H: |view1-|)
        withVFL(V: |view1-|)
    }
    
    func testCanCompile_leadingSpaceEdgedView() {
        withVFL(H: |-view1)
        withVFL(V: |-view1)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withAdjacentView() {
        withVFL(H: |-view1 | view2)
        withVFL(V: |-view1 | view2)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withSpacedView() {
        withVFL(H: |-view1 - view2)
        withVFL(V: |-view1 - view2)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withSpecificNumberSpacedView() {
        withVFL(H: |-view1 - 4 - view2)
        withVFL(V: |-view1 - 4 - view2)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withPredicateSpacedView() {
        withVFL(H: |-view1 - (>=200) - view2)
        withVFL(V: |-view1 - (>=200) - view2)
    }
    
    func testCanCompile_trailingSpaceEdgedView() {
        withVFL(H: view1-|)
        withVFL(V: view1-|)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withAdjacentView() {
        withVFL(H: view1 | view2-|)
        withVFL(V: view1 | view2-|)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withSpacedView() {
        withVFL(H: view1 - view2-|)
        withVFL(V: view1 - view2-|)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withSpecificNumberSpacedView() {
        withVFL(H: view1 - 4 - view2-|)
        withVFL(V: view1 - 4 - view2-|)
    }
    
    func testCanCompile_trailingSpaceEdgedView_withPredicateSpacedView() {
        withVFL(H: view1 - (>=200) - view2-|)
        withVFL(V: view1 - (>=200) - view2-|)
    }
    
    func testCanCompile_specificNumberLeadingSpaceEdgedView() {
        withVFL(H: |-4 - view1)
        withVFL(V: |-4 - view1)
    }
    
    func testCanCompile_specificNumberTrailingSpaceEdgedView() {
        withVFL(H: view1 - 4-|)
        withVFL(V: view1 - 4-|)
    }
    
    func testCanCompile_predicateLeadingSpaceEdgedView() {
        withVFL(H: |-(>=4) - view1)
        withVFL(V: |-(>=4) - view1)
    }
    
    func testCanCompile_predicateTrailingSpaceEdgedView() {
        withVFL(H: view1 - (>=4)-|)
        withVFL(V: view1 - (>=4)-|)
    }
    
    func testCanCompile_leadingSpaceEdgedView_withPredicate() {
        withVFL(H: |-view1.where(200))
        withVFL(V: |-view1.where(200))
    }
    
    func testCanCompile_trailingSpaceEdgedView_withPredicate() {
        withVFL(H: view1.where(200)-|)
        withVFL(V: view1.where(200)-|)
    }
    
    func testCanCompile_adjacentViews() {
        withVFL(H: view1 | view2)
        withVFL(V: view1 | view2)
    }
    
    func testCanCompile_adjacentViews_ofMultipleTimes() {
        withVFL(H: view1 | view2 | view3)
        withVFL(V: view1 | view2 | view3)
    }
    
    func testCanCompile_spacedViews() {
        withVFL(H: view1 - view2)
        withVFL(V: view1 - view2)
    }
    
    func testCanCompile_specificNumberSpacedViews() {
        withVFL(H: view1 - 2 - view2)
        withVFL(V: view1 - 2 - view2)
    }
    
    func testCanCompile_predicateSpacedViews() {
        withVFL(H: view1 - (<=200) - view2)
        withVFL(V: view1 - (<=200) - view2)
    }
    
    // Swift compiler currently cannot complete type-checking in a
    // reasonable time with following expressions.
    
    func testCanCompile_specificNumberSpacedViews_ofMultipleTimes() {
        withVFL(H: view1 - 2 - view2 - 4 - view3)
        withVFL(V: view1 - 2 - view2 - 4 - view3)
    }
    
    /*
    func testCanCompile_mixedSpacedViews1_ofMultipleTimes() {
        withVFL(H: view1 - (<=200) - view2 - 4 - view3)
        withVFL(V: view1 - (<=200) - view2 - 4 - view3)
    }
    
    func testCanCompile_mixedSpacedViews2_ofMultipleTimes() {
        withVFL(H: view1 - 4 - view2 - (<=200) - view3)
        withVFL(V: view1 - 4 - view2 - (<=200) - view3)
    }*/
}

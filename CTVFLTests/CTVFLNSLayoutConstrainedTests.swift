//
//  CTVFLNSLayoutConstrainedTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLNSLayoutConstrainedTests: XCTestCase {
    func test_commonAncestor_returnsNil_withNoView() {
        XCTAssert([CTVFLView]()._commonAncestor == nil)
    }
    
    func test_commonAncestor_returnsNil_withOneViewWithoutSuperview() {
        XCTAssert([CTVFLView()]._commonAncestor == nil)
    }
    
    func test_commonAncestor_returnsSuperview_withOneViewWithSuperview() {
        let rootView = CTVFLView()
        
        let upperView = CTVFLView()
        
        rootView.addSubview(upperView)
        
        XCTAssert([upperView]._commonAncestor === rootView)
    }
    
    func test_commonAncestor_returnsSuperview_withNestedView() {
        XCTAssert([CTVFLView()]._commonAncestor == nil)
        
        let rootView = CTVFLView()
        
        let upperView = CTVFLView()
        
        rootView.addSubview(upperView)
        
        XCTAssert([rootView, upperView]._commonAncestor === rootView)
    }
    
    func test_commonAncestor_returnsNil_withViewsWithoutNoCommonAncestor() {
        let views = (0...5).map({ _ in CTVFLView()})
        XCTAssert(views._commonAncestor == nil)
    }
    
    func test_commonAncestor_returnsCommonAncestor_withViewsHaveCommonAncestor() {
        let rootView = CTVFLView()
        
        let viewA1 = CTVFLView()
        let viewA2 = CTVFLView()
        let viewA3 = CTVFLView()
        let viewA4 = CTVFLView()
        let viewA5 = CTVFLView()
        
        let viewB1 = CTVFLView()
        let viewB2 = CTVFLView()
        let viewB3 = CTVFLView()
        let viewB4 = CTVFLView()
        let viewB5 = CTVFLView()
        
        
        rootView.addSubview(viewA1)
        rootView.addSubview(viewA2)
        rootView.addSubview(viewA3)
        rootView.addSubview(viewA4)
        rootView.addSubview(viewA5)
        viewA3.addSubview(viewB1)
        viewA3.addSubview(viewB2)
        viewA4.addSubview(viewB3)
        viewA4.addSubview(viewB4)
        viewA1.addSubview(viewB5)
        
        let views = [viewA1, viewA2, viewA3, viewA4, viewA5, viewB1, viewB2, viewB3, viewB4, viewB5]
        
        XCTAssert(views._commonAncestor === rootView)
    }
}

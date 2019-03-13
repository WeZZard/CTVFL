//
//  ViewTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class ViewTests: XCTestCase {
    func testCommonAncestorWithZeroView() {
        XCTAssert([View]()._commonAncestor == nil)
    }
    
    func testCommonAncestorWithOneView() {
        XCTAssert([View()]._commonAncestor == nil)
        
        let rootView = View()
        
        let upperView = View()
        
        rootView.addSubview(upperView)
        
        XCTAssert([upperView]._commonAncestor === rootView)
    }
    
    func testCommonAncestorWithViewsHaveNoCommonAncestor() {
        let views = (0...5).map({ _ in View()})
        XCTAssert(views._commonAncestor == nil)
    }
    
    func testCommonAncestorWithViewsHaveCommonAncestor() {
        let rootView = View()
        
        let viewA1 = View()
        let viewA2 = View()
        let viewA3 = View()
        let viewA4 = View()
        let viewA5 = View()
        
        let viewB1 = View()
        let viewB2 = View()
        let viewB3 = View()
        let viewB4 = View()
        let viewB5 = View()
        
        
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

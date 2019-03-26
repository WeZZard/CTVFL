//
//  CTVFLConstraintTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLConstraintTests: XCTestCase {
    var view: View!
    var subview: View!
    
    var viewWidthConstraint: NSLayoutConstraint!
    
    override func setUp() {
        super.setUp()
        view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        subview = View()
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subview)
        
        viewWidthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    }
    
    override func tearDown() {
        super.tearDown()
        
        subview = nil
        view = nil
        
        viewWidthConstraint = nil
    }
    
    func testInitWithHolderLayoutConstraint() {
        let constraint = _CTVFLConstraint(view: view, constraint: viewWidthConstraint)
        XCTAssert(constraint.view === view)
        XCTAssert(constraint.constraint === viewWidthConstraint)
    }
    
    func testIsActive() {
        let constraint = _CTVFLConstraint(view: view, constraint: viewWidthConstraint)
        
        XCTAssert(viewWidthConstraint.isActive == constraint.isActive)
        
        constraint.isActive = false
        XCTAssert(!viewWidthConstraint.isActive)
        XCTAssert(viewWidthConstraint.isActive == constraint.isActive)
        
        constraint.isActive = true
        XCTAssert(viewWidthConstraint.isActive)
        XCTAssert(viewWidthConstraint.isActive == constraint.isActive)
    }
    
    func testInstall() {
        let constraint = _CTVFLConstraint(view: view, constraint: viewWidthConstraint)
        XCTAssert(view.constraints.index(of: constraint.constraint) == nil)
        constraint.install()
        XCTAssert(view.constraints.index(of: constraint.constraint) != nil)
    }
    
    func testUninstall() {
        let constraint = _CTVFLConstraint(view: view, constraint: viewWidthConstraint)
        XCTAssert(view.constraints.index(of: constraint.constraint) == nil)
        constraint.install()
        XCTAssert(view.constraints.index(of: constraint.constraint) != nil)
        constraint.uninstall()
        XCTAssert(view.constraints.index(of: constraint.constraint) == nil)
    }
    
}

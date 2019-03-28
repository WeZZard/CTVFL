//
//  _CTVFLConstraintHandlerTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class _CTVFLConstraintHandlerTests: XCTestCase {
    var view: CTVFLView!
    var subview: CTVFLView!
    
    var viewWidthConstraint: NSLayoutConstraint!
    
    override func setUp() {
        super.setUp()
        view = CTVFLView()
        view.translatesAutoresizingMaskIntoConstraints = false
        subview = CTVFLView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subview)
        
        viewWidthConstraint = NSLayoutConstraint(item: view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    }
    
    override func tearDown() {
        super.tearDown()
        
        subview = nil
        view = nil
        
        viewWidthConstraint = nil
    }
    
    func testInitWithHolderLayoutConstraint() {
        let handler = _CTVFLConstraintHandler(view: view, constraint: viewWidthConstraint)
        XCTAssert(handler.view === view)
        XCTAssert(handler.constraint === viewWidthConstraint)
    }
    
    func testIsActive() {
        let handler = _CTVFLConstraintHandler(view: view, constraint: viewWidthConstraint)
        
        XCTAssert(viewWidthConstraint.isActive == handler.isActive)
        
        handler.isActive = false
        XCTAssert(!viewWidthConstraint.isActive)
        XCTAssert(viewWidthConstraint.isActive == handler.isActive)
        
        handler.isActive = true
        XCTAssert(viewWidthConstraint.isActive)
        XCTAssert(viewWidthConstraint.isActive == handler.isActive)
    }
    
    func testInstall() {
        let handler = _CTVFLConstraintHandler(view: view, constraint: viewWidthConstraint)
        XCTAssert(view.constraints.firstIndex(of: handler.constraint) == nil)
        handler.install()
        XCTAssert(view.constraints.firstIndex(of: handler.constraint) != nil)
    }
    
    func testUninstall() {
        let handler = _CTVFLConstraintHandler(view: view, constraint: viewWidthConstraint)
        XCTAssert(view.constraints.firstIndex(of: handler.constraint) == nil)
        handler.install()
        XCTAssert(view.constraints.firstIndex(of: handler.constraint) != nil)
        handler.uninstall()
        XCTAssert(view.constraints.firstIndex(of: handler.constraint) == nil)
    }
    
}

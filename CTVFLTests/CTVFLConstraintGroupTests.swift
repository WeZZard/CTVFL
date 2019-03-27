//
//  CTVFLConstraintGroupTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLConstraintGroupTests: XCTestCase {
    var view: CTVFLView!
    var subview: CTVFLView!
    
    var viewWidth100Constraint: NSLayoutConstraint!
    var viewHeight100Constraint: NSLayoutConstraint!
    
    override func setUp() {
        super.setUp()
        view = CTVFLView()
        view.translatesAutoresizingMaskIntoConstraints = false
        subview = CTVFLView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subview)
        
        viewWidth100Constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        viewHeight100Constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    }
    
    override func tearDown() {
        super.tearDown()
        
        subview = nil
        view = nil
        viewWidth100Constraint = nil
        viewHeight100Constraint = nil
    }
    
    func testInit() {
        let group = CTVFLConstraintGroup()
        XCTAssert(group._handlers.isEmpty)
        XCTAssert(!group.areAllAcrive)
    }
    
    func testReplaceConstraints() {
        let handler1 = _CTVFLConstraintHandler(view: view, constraint: viewWidth100Constraint)
        let handler2 = _CTVFLConstraintHandler(view: view, constraint: viewHeight100Constraint)
        let handlers: ContiguousArray<_CTVFLConstraintHandler> = [handler1, handler2]
        let group = CTVFLConstraintGroup()
        XCTAssert(group._handlers.isEmpty)
        group._replaceConstraintHandlers(handlers)
        XCTAssert(group._handlers.elementsEqual(handlers, by: ===))
    }
    
    func testIsActive() {
        let handler1 = _CTVFLConstraintHandler(view: view, constraint: viewWidth100Constraint)
        let handler2 = _CTVFLConstraintHandler(view: view, constraint: viewHeight100Constraint)
        let handlers: ContiguousArray<_CTVFLConstraintHandler> = [handler1, handler2]
        let group = CTVFLConstraintGroup()
        XCTAssert(!group.areAllAcrive)
        group._replaceConstraintHandlers(handlers)
        XCTAssert(group.areAllAcrive)
        group.setActive(false)
        XCTAssert(!group.areAllAcrive)
        group.setActive(true)
        XCTAssert(group.areAllAcrive)
        viewWidth100Constraint.isActive = false
        XCTAssert(!group.areAllAcrive)
    }
    
}

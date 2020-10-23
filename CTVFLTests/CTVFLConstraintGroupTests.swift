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
        
        viewWidth100Constraint = NSLayoutConstraint(item: view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        viewHeight100Constraint = NSLayoutConstraint(item: view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
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
        XCTAssert(!group.areAllActive)
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
        XCTAssert(!group.areAllActive)
        group._replaceConstraintHandlers(handlers)
        XCTAssert(group.areAllActive)
        group.setActive(false)
        XCTAssert(!group.areAllActive)
        group.setActive(true)
        XCTAssert(group.areAllActive)
        viewWidth100Constraint.isActive = false
        XCTAssert(!group.areAllActive)
    }
    
}

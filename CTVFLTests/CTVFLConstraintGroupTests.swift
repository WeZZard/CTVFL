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
    var view: View!
    var subview: View!
    
    var viewWidth100Constraint: NSLayoutConstraint!
    var viewHeight100Constraint: NSLayoutConstraint!
    
    override func setUp() {
        super.setUp()
        view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        subview = View()
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
        XCTAssert(group._constraints.isEmpty)
        XCTAssert(!group.areAllAcrive)
    }
    
    func testReplaceConstraints() {
        let constraint1 = _CTVFLConstraint(view: view, constraint: viewWidth100Constraint)
        let constraint2 = _CTVFLConstraint(view: view, constraint: viewHeight100Constraint)
        let constraints = [constraint1, constraint2]
        let group = CTVFLConstraintGroup()
        XCTAssert(group._constraints.isEmpty)
        group._replaceConstraints(constraints)
        XCTAssert(group._constraints.elementsEqual(constraints, by: ===))
    }
    
    func testIsActive() {
        let constraint1 = _CTVFLConstraint(view: view, constraint: viewWidth100Constraint)
        let constraint2 = _CTVFLConstraint(view: view, constraint: viewHeight100Constraint)
        let constraints = [constraint1, constraint2]
        let group = CTVFLConstraintGroup()
        XCTAssert(!group.areAllAcrive)
        group._replaceConstraints(constraints)
        XCTAssert(group.areAllAcrive)
        group.setActive(false)
        XCTAssert(!group.areAllAcrive)
        group.setActive(true)
        XCTAssert(group.areAllAcrive)
        viewWidth100Constraint.isActive = false
        XCTAssert(!group.areAllAcrive)
    }
    
}

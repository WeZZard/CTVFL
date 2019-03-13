//
//  CTVFLGlobalContextTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLGlobalContextTests: XCTestCase {
    var context: CTVFLGlobalContext!
    
    override func setUp() {
        super.setUp()
        context = CTVFLGlobalContext()
    }
    
    override func tearDown() {
        super.tearDown()
        context = nil
    }
    
    func testInit() {
        XCTAssert(context.overridingNameForVariable.isEmpty)
        XCTAssert(context.overridingVariables.isEmpty)
        XCTAssert(context.constraints.isEmpty)
    }
    
    func testManagingContextStack() {
        XCTAssert(CTVFLGlobalContext.shared == nil)
        
        XCTAssert(CTVFLGlobalContext.contexts.isEmpty)
        
        let shared = CTVFLGlobalContext.push()
        
        XCTAssert(CTVFLGlobalContext.contexts.elementsEqual([shared], by: {$0 === $1}))
        
        XCTAssert(CTVFLGlobalContext.shared === shared)
        
        CTVFLGlobalContext.pop()
        
        XCTAssert(CTVFLGlobalContext.contexts.isEmpty)
        
        XCTAssert(CTVFLGlobalContext.shared == nil)
    }
    
    func testRegisterConstraints() {
        let rootView = View()
        let view1 = View()
        let view2 = View()
        rootView.addSubview(view1)
        rootView.addSubview(view2)
        
        let syntax = |-view1 - view2-|
        
        let inlineContext = CTVFLInlineContext()
        
        let visualFormat = syntax.makePrimitiveVisualFormat(with: inlineContext)
        
        let views = inlineContext._views
        
        XCTAssert(context.constraints.isEmpty)
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: nil, views: views)
        
        context.registerConstraints(constraints, with: views.values)
        
        XCTAssert(context.constraints.map({$0.constraint}).elementsEqual(constraints, by: {$0 == $1}))
        
        XCTAssert(Set(rootView.constraints).intersection(Set(constraints)).elementsEqual([]))
    }
    
    func testOverridingNameForVariables() {
        let variableName = "test"
        let view = View()
        let variable = CTVFLVariable(view)
        XCTAssert(context.overridingVariables.isEmpty)
        context.setOverridingName(variableName, for: variable)
        XCTAssert(context.overridingName(for: variable) == variableName)
        XCTAssert(context.overridingNameForVariable[variable] == variableName)
        XCTAssert(context.overridingVariables[variableName] == variable)
    }
}

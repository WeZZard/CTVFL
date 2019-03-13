//
//  CTVFLInlineContextTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

class CTVFLInlineContextTests: XCTestCase {
    var context: CTVFLInlineContext!
    
    override func setUp() {
        super.setUp()
        context = CTVFLInlineContext()
    }
    
    override func tearDown() {
        super.tearDown()
        context = nil
    }
    
    func testInit() {
        XCTAssert(context._existedNames.isEmpty)
        XCTAssert(context._nameForVariable.isEmpty)
        XCTAssert(context._views.isEmpty)
    }
    
    func test_nameForVariableAlwaysReturnsTheSameValue() {
        let view = View()
        let variable = CTVFLVariable(view)
        let name = context._name(forVariable: variable)
        XCTAssert(name == context._name(forVariable: variable))
    }
    
    func test_nameForVariableRecognizesEqualVariable() {
        let view = View()
        let variable1 = CTVFLVariable(view)
        let variable2 = CTVFLVariable(view)
        let name1 = context._name(forVariable: variable1)
        let name2 = context._name(forVariable: variable2)
        XCTAssert(name1 == name2)
    }
    
    func test_nameForVariableRespectsOverriding() {
        let view = View()
        let variable = CTVFLVariable(view)
        
        let mangledName = context._name(forVariable: variable)
        let overridingVariableName = "test"
        
        XCTAssert(mangledName == context._name(forVariable: variable))
        
        CTVFLGlobalContext.push()
        
        setVariableName(overridingVariableName, for: variable)
        
        XCTAssert(overridingVariableName == context._name(forVariable: variable))
        
        CTVFLGlobalContext.pop()
        
        XCTAssert(mangledName == context._name(forVariable: variable))
    }
    
    func test_existedNames() {
        let view1 = View()
        let view1Prime = view1
        let view2 = View()
        
        let variable1 = CTVFLVariable(view1)
        let variable1Prime = CTVFLVariable(view1Prime)
        let variable2 = CTVFLVariable(view2)
        
        let name1 = context._name(forVariable: variable1)
        let name1Prime = context._name(forVariable: variable1Prime)
        let name2 = context._name(forVariable: variable2)
        
        XCTAssert(context._existedNames.elementsEqual(Set([name1, name1Prime, name2])))
        
    }
    
    func test_existedNamesIncludesOverridingNames() {
        let view1 = View()
        let view1Prime = view1
        let view2 = View()
        
        let variable1 = CTVFLVariable(view1)
        let variable1Prime = CTVFLVariable(view1Prime)
        let variable2 = CTVFLVariable(view2)
        
        let name1 = context._name(forVariable: variable1)
        let name1Prime = context._name(forVariable: variable1Prime)
        let name2 = context._name(forVariable: variable2)
        
        CTVFLGlobalContext.push()
        
        let overridingName2 = "test"
        XCTAssertNotEqual(overridingName2, name2)
        
        setVariableName(overridingName2, for: variable2)
        
        XCTAssertEqual(context._existedNames, Set([name1, name1Prime, name2, overridingName2]))
        
        CTVFLGlobalContext.pop()
    }
    
    
    func test_views() {
        let view1 = View()
        let view2 = View()
        
        let variable1 = CTVFLVariable(view1)
        let variable2 = CTVFLVariable(view2)
        
        let name1 = context._name(forVariable: variable1)
        let name2 = context._name(forVariable: variable2)
        
        XCTAssert(context._views == [name1: view1, name2: view2])
    }
    
    func test_viewsIncludesOverridingNames() {
        let view1 = View()
        let view2 = View()
        
        let variable1 = CTVFLVariable(view1)
        let variable2 = CTVFLVariable(view2)
        
        let name1 = context._name(forVariable: variable1)
        let name2 = context._name(forVariable: variable2)
        
        CTVFLGlobalContext.push()
        
        let overridingName2 = "test"
        XCTAssert(overridingName2 != name2)
        
        setVariableName(overridingName2, for: variable2)
        
        XCTAssert(context._views == [name1: view1, name2: view2, overridingName2: view2])
        CTVFLGlobalContext.pop()
    }
}

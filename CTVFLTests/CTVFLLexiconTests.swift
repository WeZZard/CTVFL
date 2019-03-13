//
//  CTVFLLexiconTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

import XCTest

@testable
import CTVFL

// MARK: CTVFLLexiconTests
class CTVFLLexiconTests: XCTestCase {
    func test_makeVisualFormatWithInlineContextOrientation() {
        let context = CTVFLInlineContext()
        
        XCTAssert(DummyLexicon()._makeVisualFormat(with: context, orientation: .horizontal) == "H:")
        
        XCTAssert(DummyLexicon(indicator: "Test")._makeVisualFormat(with: context, orientation: .horizontal) == "H:Test")
        
        XCTAssert(DummyLexicon()._makeVisualFormat(with: context, orientation: .vertical) == "V:")
        
        XCTAssert(DummyLexicon(indicator: "Test")._makeVisualFormat(with: context, orientation: .vertical) == "V:Test")
    }
}

// MARK: CTVFLConstantLexiconTests
class CTVFLConstantLexiconTests: XCTestCase {
    var constant: CTVFLConstant!
    var lexicon: CTVFLConstantLexicon!
    
    override func setUp() {
        super.setUp()
        constant = CTVFLConstant(rawValue: Double(arc4random()))
        lexicon = CTVFLConstantLexicon(constant: constant)
    }
    
    override func tearDown() {
        super.tearDown()
        constant = nil
        lexicon = nil
    }
    
    func testMakePrimitiveVisualFormatWithInlineContext() {
        let context = CTVFLInlineContext()
        let primitiveVisualFormat = lexicon.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "\(constant.description)")
    }
}

// MARK: CTVFLVariableLexiconTests
class CTVFLVariableLexiconTests: XCTestCase {
    var variable: CTVFLVariable!
    var lexicon: CTVFLVariableLexicon!
    
    override func setUp() {
        super.setUp()
        variable = CTVFLVariable(View())
        lexicon = CTVFLVariableLexicon(variable: variable)
    }
    
    override func tearDown() {
        super.tearDown()
        variable = nil
        lexicon = nil
    }
    
    func testMakePrimitiveVisualFormatWithInlineContext() {
        let context = CTVFLInlineContext()
        let primitiveVisualFormat = lexicon.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "[\(context._name(forVariable: variable))]")
    }
}

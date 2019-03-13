//
//  CTVFLSyntaxTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

import XCTest

@testable
import CTVFL

class CTVFLSyntaxTests: XCTestCase {
    var context: CTVFLInlineContext!
    
    override func setUp() {
        super.setUp()
        context = CTVFLInlineContext()
    }
    
    override func tearDown() {
        super.tearDown()
        context = nil
    }
    
    func testLeadingSyntax() {
        XCTAssert(CTVFLLeadingSyntax(lexicon: DummyVariableLexicon()).makePrimitiveVisualFormat(with: context) == "|")
        XCTAssert(CTVFLLeadingSyntax(lexicon: DummyVariableLexicon(indicator: "Test")).makePrimitiveVisualFormat(with: context) == "|Test")
    }
    
    func testTrailingSyntax() {
        XCTAssert(CTVFLTrailingSyntax(lexicon: DummyVariableLexicon()).makePrimitiveVisualFormat(with: context) == "|")
        XCTAssert(CTVFLTrailingSyntax(lexicon: DummyVariableLexicon(indicator: "Test")).makePrimitiveVisualFormat(with: context) == "Test|")
    }
    
    func testSpacedLeadingSyntax() {
        XCTAssert(CTVFLSpacedLeadingSyntax(lexicon: DummyVariableLexicon()).makePrimitiveVisualFormat(with: context) == "|-")
        XCTAssert(CTVFLSpacedLeadingSyntax(lexicon: DummyVariableLexicon(indicator: "Test")).makePrimitiveVisualFormat(with: context) == "|-Test")
    }
    
    func testSpacedTrailingSyntax() {
        XCTAssert(CTVFLSpacedTrailingSyntax(lexicon: DummyVariableLexicon()).makePrimitiveVisualFormat(with: context) == "-|")
        XCTAssert(CTVFLSpacedTrailingSyntax(lexicon: DummyVariableLexicon(indicator: "Test")).makePrimitiveVisualFormat(with: context) == "Test-|")
    }
    
    func testSpacedSyntax() {
        XCTAssert(CTVFLSpacedSyntax(lhs: DummyLexicon(), rhs: DummyLexicon()).makePrimitiveVisualFormat(with: context) == "-")
        XCTAssert(CTVFLSpacedSyntax(lhs: DummyLexicon(indicator: "lhs"), rhs: DummyLexicon()).makePrimitiveVisualFormat(with: context) == "lhs-")
        XCTAssert(CTVFLSpacedSyntax(lhs: DummyLexicon(), rhs: DummyLexicon(indicator: "rhs")).makePrimitiveVisualFormat(with: context) == "-rhs")
        XCTAssert(CTVFLSpacedSyntax(lhs: DummyLexicon(indicator: "lhs"), rhs: DummyLexicon(indicator: "rhs")).makePrimitiveVisualFormat(with: context) == "lhs-rhs")
    }
    
    func testAdjacentSyntax() {
        XCTAssert(CTVFLAdjacentSyntax(lhs: DummyVariableLexicon(), rhs: DummyVariableLexicon()).makePrimitiveVisualFormat(with: context) == "")
        XCTAssert(CTVFLAdjacentSyntax(lhs: DummyVariableLexicon(indicator: "lhs"), rhs: DummyVariableLexicon()).makePrimitiveVisualFormat(with: context) == "lhs")
        XCTAssert(CTVFLAdjacentSyntax(lhs: DummyVariableLexicon(), rhs: DummyVariableLexicon(indicator: "rhs")).makePrimitiveVisualFormat(with: context) == "rhs")
        XCTAssert(CTVFLAdjacentSyntax(lhs: DummyVariableLexicon(indicator: "lhs"), rhs: DummyVariableLexicon(indicator: "rhs")).makePrimitiveVisualFormat(with: context) == "lhsrhs")
    }
    
    func testBacketedVariableSyntax() {
        let dummyLexicon = DummyVariableLexicon()
        let dummyLexiconWithContent = DummyVariableLexicon(indicator: "Test")
        
        let dummySyntax = CTVFLTrailingSyntax(lexicon: dummyLexicon)
        let dummySyntaxWithContent = CTVFLTrailingSyntax(lexicon: dummyLexiconWithContent)
        
        XCTAssert(CTVFLBracketedVariableSyntax(trailingSyntax: dummySyntax, hasLeadingSpacing: false).makePrimitiveVisualFormat(with: context) == "||")
        XCTAssert(CTVFLBracketedVariableSyntax(trailingSyntax: dummySyntax, hasLeadingSpacing: true).makePrimitiveVisualFormat(with: context) == "|-|")
        
        XCTAssert(CTVFLBracketedVariableSyntax(trailingSyntax: dummySyntaxWithContent, hasLeadingSpacing: false).makePrimitiveVisualFormat(with: context) == "|Test|")
        XCTAssert(CTVFLBracketedVariableSyntax(trailingSyntax: dummySyntaxWithContent, hasLeadingSpacing: true).makePrimitiveVisualFormat(with: context) == "|-Test|")
    }
    
    func testBacketedSpacedVariableSyntax() {
        let dummyLexicon = DummyVariableLexicon()
        let dummyLexiconWithContent = DummyVariableLexicon(indicator: "Test")
        
        let dummySyntax = CTVFLSpacedTrailingSyntax(lexicon: dummyLexicon)
        let dummySyntaxWithContent = CTVFLSpacedTrailingSyntax(lexicon: dummyLexiconWithContent)
        
        XCTAssert(CTVFLBracketedSpacedVariableSyntax(trailingSyntax: dummySyntax, hasLeadingSpacing: false).makePrimitiveVisualFormat(with: context) == "|-|")
        XCTAssert(CTVFLBracketedSpacedVariableSyntax(trailingSyntax: dummySyntax, hasLeadingSpacing: true).makePrimitiveVisualFormat(with: context) == "|--|")
        
        XCTAssert(CTVFLBracketedSpacedVariableSyntax(trailingSyntax: dummySyntaxWithContent, hasLeadingSpacing: false).makePrimitiveVisualFormat(with: context) == "|Test-|")
        XCTAssert(CTVFLBracketedSpacedVariableSyntax(trailingSyntax: dummySyntaxWithContent, hasLeadingSpacing: true).makePrimitiveVisualFormat(with: context) == "|-Test-|")
    }
}

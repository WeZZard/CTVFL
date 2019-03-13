//
//  CTVFLPredicateTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

@testable
import CTVFL

// MARK: - CTVFLPredicateTests
class CTVFLPredicateTests: XCTestCase {
    typealias Relation = CTVFLPredicate._Relation
    
    var priority: Priority!
    
    var relation: Relation!
    
    var predicateObject: CTVFLVariantPredicateObject!
    
    var predicate: CTVFLPredicate!
    
    override func setUp() {
        super.setUp()
        priority = Priority(Float(arc4random_uniform(1000)))
        let relationSeed = arc4random_uniform(2)
        relation = relationSeed == 0
            ? .equal
            : (relationSeed == 1 ? .greaterThanOrEqual : .lessThanOrEqual)
        predicateObject = .constant(CTVFLConstant(rawValue: 100))
        predicate = CTVFLPredicate(predicate: predicateObject, relation: relation, priority: priority)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_priority() {
        XCTAssert(predicate._priority == priority)
    }
    
    func test_relation() {
        XCTAssert(predicate._relation == relation)
    }
    
    func test_predicate() {
        XCTAssert(predicate._predicate == predicateObject)
    }
    
    // MARK: Testing <=
    func testLessThanOrEqualPredicateWithIntegerLiteral() {
        let predicate = <=1
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(1.0)")
    }
    
    func testLessThanOrEqualPredicateWithFloatLiteral() {
        let predicate = <=1.0
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(1.0)")
    }
    
    func testLessThanOrEqualPredicateWithInt() {
        let value = Int(1)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(1.0)")
    }
    
    func testLessThanOrEqualPredicateWithDouble() {
        let value = Double(1.0)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(value)")
    }
    
    func testLessThanOrEqualPredicateWithFloat() {
        let value = Float(1.0)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(value)")
    }
    
    func testLessThanOrEqualPredicateWithCGFloat() {
        let value = CGFloat(1.0)
        let predicate = <=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "<=\(value)")
    }
    
    // MARK: Testing ==
    func testEqualPredicateWithIntegerLiteral() {
        let predicate = ==1
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(1.0)")
    }
    
    func testEqualPredicateWithFloatLiteral() {
        let predicate = ==1.0
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(1.0)")
    }
    
    func testEqualPredicateWithInt() {
        let value = Int(1)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(1.0)")
    }
    
    func testEqualPredicateWithDouble() {
        let value = Double(1.0)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(value)")
    }
    
    func testEqualPredicateWithFloat() {
        let value = Float(1.0)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(value)")
    }
    
    func testEqualPredicateWithCGFloat() {
        let value = CGFloat(1.0)
        let predicate = ==value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == "==\(value)")
    }
    
    // MARK: Testing >=
    func testGreaterThanOrEqualPredicateWithIntegerLiteral() {
        let predicate = >=1
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(1.0)")
    }
    
    func testGreaterThanOrEqualPredicateWithFloatLiteral() {
        let predicate = >=1.0
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(1.0)")
    }
    
    func testGreaterThanOrEqualPredicateWithInt() {
        let value = Int(1)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(1.0)")
    }
    
    func testGreaterThanOrEqualPredicateWithDouble() {
        let value = Double(1.0)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(value)")
    }
    
    func testGreaterThanOrEqualPredicateWithFloat() {
        let value = Float(1.0)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(value)")
    }
    
    func testGreaterThanOrEqualPredicateWithCGFloat() {
        let value = CGFloat(1.0)
        let predicate = >=value
        let context = CTVFLInlineContext()
        
        let primitiveVisualFormat = predicate.makePrimitiveVisualFormat(with: context)
        XCTAssert(primitiveVisualFormat == ">=\(value)")
    }
}

// MARK: - CTVFLPredicateRelationTests
class CTVFLPredicateRelationTests: XCTestCase {
    typealias Relation = CTVFLPredicate._Relation
    
    func testEqual() {
        XCTAssert(Relation.equal.description == "==")
    }
    
    func testGreaterThanOrEqual() {
        XCTAssert(Relation.greaterThanOrEqual.description == ">=")
    }
    
    func testLessThanOrEqual() {
        XCTAssert(Relation.lessThanOrEqual.description == "<=")
    }
}

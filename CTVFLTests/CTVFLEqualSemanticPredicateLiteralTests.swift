//
//  CTVFLEqualSemanticPredicateLiteralTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

import XCTest

@testable
import CTVFL

class CTVFLEqualSemanticPredicateLiteralTests: XCTestCase {
    func testInt_toCTVFLPredicate() {
        let value = Int(arc4random())
        let predicate = value._toCTVFLPredicate()
        
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(value))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == .required)
    }
    
    func testDouble_toCTVFLPredicate() {
        let value = Double(arc4random())
        let predicate = value._toCTVFLPredicate()
        
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(value))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == .required)
    }
    
    func testFloat_toCTVFLPredicate() {
        let value = Float(arc4random())
        let predicate = value._toCTVFLPredicate()
        
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(value))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == .required)
    }
    
    func testCGFloat_toCTVFLPredicate() {
        let value = CGFloat(arc4random())
        let predicate = value._toCTVFLPredicate()
        
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(value))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == .required)
    }
    
    func testMakePrioritiedEqualSemanticPredicateWithPriority() {
        let priority = Priority(100)
        let predicateValue = Int(1)
        let predicate = 1 ~ priority
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(predicateValue))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == priority)
    }
    
    func testMakePrioritiedEqualSemanticPredicateWithInt() {
        let priority = Int(100)
        let predicateValue = Int(1)
        let predicate = 1 ~ priority
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(predicateValue))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == Priority(Float(priority)))
    }
    
    func testMakePrioritiedEqualSemanticPredicateWithFloat() {
        let priority = Float(100)
        let predicateValue = Int(1)
        let predicate = 1 ~ priority
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(predicateValue))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == Priority(priority))
    }
    
    func testMakePrioritiedEqualSemanticPredicateWithDouble() {
        let priority = Double(100)
        let predicateValue = Int(1)
        let predicate = 1 ~ priority
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(predicateValue))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == Priority(Float(priority)))
    }
    
    func testMakePrioritiedEqualSemanticPredicateWithCGFloat() {
        let priority = CGFloat(100)
        let predicateValue = Int(1)
        let predicate = 1 ~ priority
        XCTAssert(predicate._predicate == .constant(.init(rawValue: Double(predicateValue))))
        XCTAssert(predicate._relation == .equal)
        XCTAssert(predicate._priority == Priority(Float(priority)))
    }
}

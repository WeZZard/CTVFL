//
//  CTVFLEqualSemanticPredicateLiteral.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

import CoreGraphics

// MARK: CTVFLEqualSemanticPredicateLiteral
public protocol CTVFLEqualSemanticPredicateLiteral: CTVFLPredicating {}

extension Int: CTVFLEqualSemanticPredicateLiteral {
    public func _toCTVFLPredicate() -> CTVFLPredicate {
        return CTVFLPredicate(constant: .init(rawValue: Double(self)), relation: .equal)
    }
}

extension Double: CTVFLEqualSemanticPredicateLiteral {
    public func _toCTVFLPredicate() -> CTVFLPredicate {
        return CTVFLPredicate(constant: .init(rawValue: self), relation: .equal)
    }
}

extension Float: CTVFLEqualSemanticPredicateLiteral {
    public func _toCTVFLPredicate() -> CTVFLPredicate {
        return CTVFLPredicate(constant: .init(rawValue: Double(self)), relation: .equal)
    }
}

extension CGFloat: CTVFLEqualSemanticPredicateLiteral {
    public func _toCTVFLPredicate() -> CTVFLPredicate {
        return CTVFLPredicate(constant: .init(rawValue: Double(self)), relation: .equal)
    }
}

// MARK: Making Priority'ed Euqal-Semantic Predicate
public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: Priority) -> CTVFLPredicate {
    return lhs._toCTVFLPredicate()._byUpdatingPriority(rhs)
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: Int) -> CTVFLPredicate {
    return lhs ~ Priority(Float(rhs))
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: Float) -> CTVFLPredicate {
    return lhs ~ Priority(rhs)
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: Double) -> CTVFLPredicate {
    return lhs ~ Priority(Float(rhs))
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: CGFloat) -> CTVFLPredicate {
    return lhs ~ Priority(Float(rhs))
}

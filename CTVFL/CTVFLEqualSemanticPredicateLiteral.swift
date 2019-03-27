//
//  CTVFLEqualSemanticPredicateLiteral.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

import CoreGraphics

// MARK: CTVFLEqualSemanticPredicateLiteral
public protocol CTVFLEqualSemanticPredicateLiteral: CTVFLPredicating {}

extension CTVFLEqualSemanticPredicateLiteral where Self: BinaryInteger {
    public func byUpdatingPriority(_ priority: CTVFLPriority) -> CTVFLGenericPredicate {
        return .constant(CTVFLConstantPredicate(constant: .init(rawValue: Float(self)), relation: .equal, priority: priority))
    }
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLConstraintOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLOptions,
        withStorage storage: inout ContiguousArray<CTVFLOpcode>
        )
    {
        return CTVFLConstantPredicate(constant: .init(rawValue: Float(self)), relation: .equal, priority: .required)
            .generateOpcodes(forOrientation: orientation, forObject: object, withOptions: options, withStorage: &storage)
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLGenericPredicate {
        return .constant(CTVFLConstantPredicate(constant: .init(rawValue: Float(self)), relation: .equal))
    }
}

extension CTVFLEqualSemanticPredicateLiteral where Self: BinaryFloatingPoint {
    public func byUpdatingPriority(_ priority: CTVFLPriority) -> CTVFLGenericPredicate {
        return .constant(CTVFLConstantPredicate(constant: .init(rawValue: Float(self)), relation: .equal, priority: priority))
    }
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLConstraintOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLOptions,
        withStorage storage: inout ContiguousArray<CTVFLOpcode>
        )
    {
        return CTVFLConstantPredicate(constant: .init(rawValue: Float(self)), relation: .equal, priority: .required)
            .generateOpcodes(forOrientation: orientation, forObject: object, withOptions: options, withStorage: &storage)
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLGenericPredicate {
        return .constant(CTVFLConstantPredicate(constant: .init(rawValue: Float(self)), relation: .equal))
    }
}

extension Int: CTVFLEqualSemanticPredicateLiteral { }

extension Double: CTVFLEqualSemanticPredicateLiteral { }

extension Float: CTVFLEqualSemanticPredicateLiteral { }

extension CGFloat: CTVFLEqualSemanticPredicateLiteral { }

// MARK: Making Priority'ed Euqal-Semantic Predicate
public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: CTVFLPriority) -> CTVFLGenericPredicate {
    return lhs.toCTVFLGenericPredicate().byUpdatingPriority(rhs)
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: Int) -> CTVFLGenericPredicate {
    return lhs ~ CTVFLPriority(Float(rhs))
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: Float) -> CTVFLGenericPredicate {
    return lhs ~ CTVFLPriority(rhs)
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: Double) -> CTVFLGenericPredicate {
    return lhs ~ CTVFLPriority(Float(rhs))
}

public func ~ <P: CTVFLEqualSemanticPredicateLiteral>(lhs: P, rhs: CGFloat) -> CTVFLGenericPredicate {
    return lhs ~ CTVFLPriority(Float(rhs))
}

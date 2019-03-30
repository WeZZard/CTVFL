//
//  CTVFLExpressibleByPredicateLiteral.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

import CoreGraphics

// MARK: CTVFLExpressibleByPredicateLiteral
public protocol CTVFLExpressibleByPredicateLiteral: CTVFLPredicating {}

extension CTVFLExpressibleByPredicateLiteral where Self: BinaryInteger {
    public func byUpdatingPriority(_ priority: CTVFLPriority) -> CTVFLPredicateObjectGeneric {
        return .constant(CTVFLPredicateObjectConstant(constant: .init(rawValue: Float(self)), relation: .equal, priority: priority))
    }
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLFormatOptions,
        withContext context: CTVFLEvaluationContext
        )
    {
        return toCTVFLGenericPredicate()
            .generateOpcodes(forOrientation: orientation, forObject: object, withOptions: options, withContext: context)
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLPredicateObjectGeneric {
        return .constant(CTVFLPredicateObjectConstant(constant: .init(rawValue: Float(self)), relation: .equal))
    }
}

extension CTVFLExpressibleByPredicateLiteral where Self: BinaryFloatingPoint {
    public func byUpdatingPriority(_ priority: CTVFLPriority) -> CTVFLPredicateObjectGeneric {
        return .constant(CTVFLPredicateObjectConstant(constant: .init(rawValue: Float(self)), relation: .equal, priority: priority))
    }
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLFormatOptions,
        withContext context: CTVFLEvaluationContext
        )
    {
        return toCTVFLGenericPredicate()
            .generateOpcodes(forOrientation: orientation, forObject: object, withOptions: options, withContext: context)
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLPredicateObjectGeneric {
        return .constant(CTVFLPredicateObjectConstant(constant: .init(rawValue: Float(self)), relation: .equal))
    }
}

extension Int: CTVFLExpressibleByPredicateLiteral { }

extension Double: CTVFLExpressibleByPredicateLiteral { }

extension Float: CTVFLExpressibleByPredicateLiteral { }

extension CGFloat: CTVFLExpressibleByPredicateLiteral { }

// MARK: Making Priority'ed Euqal-Semantic Predicate
public func ~ <P: CTVFLExpressibleByPredicateLiteral>(lhs: P, rhs: CTVFLPriority) -> CTVFLPredicateObjectGeneric {
    return lhs.toCTVFLGenericPredicate().byUpdatingPriority(rhs)
}

public func ~ <Predicate: CTVFLExpressibleByPredicateLiteral, Priority: BinaryInteger>(lhs: Predicate, rhs: Priority) -> CTVFLPredicateObjectGeneric {
    return lhs ~ CTVFLPriority(Float(rhs))
}

public func ~ <Predicate: CTVFLExpressibleByPredicateLiteral, Priority: BinaryFloatingPoint>(lhs: Predicate, rhs: Priority) -> CTVFLPredicateObjectGeneric {
    return lhs ~ CTVFLPriority(Float(rhs))
}

//
//  CTVFLPredicating.swift
//  CTVFL
//
//  Created on 2019/3/26.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public enum CTVFLPredicatedObject {
    case dimension
    case position
}

public protocol CTVFLPredicating {
    func byUpdatingPriority(_ priority: CTVFLPriority) -> CTVFLPredicateObjectGeneric
    
    func generateOpcodes(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLFormatOptions,
        withContext context: CTVFLEvaluationContext
    )
    
    func toCTVFLGenericPredicate() -> CTVFLPredicateObjectGeneric
}

// MARK: - Updating Predication's Priority
public func ~ <P: CTVFLPredicating>(lhs: P, rhs: CTVFLPriority) -> CTVFLPredicateObjectGeneric {
    return lhs.byUpdatingPriority(rhs)
}

public func ~ <Predicate: CTVFLPredicating, Priority: BinaryInteger>(lhs: Predicate, rhs: Priority) -> CTVFLPredicateObjectGeneric {
    return lhs.byUpdatingPriority(CTVFLPriority(Float(rhs)))
}

public func ~ <Predicate: CTVFLPredicating, Priority: BinaryFloatingPoint>(lhs: Predicate, rhs: Priority) -> CTVFLPredicateObjectGeneric {
    return lhs.byUpdatingPriority(CTVFLPriority(Float(rhs)))
}

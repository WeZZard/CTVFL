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
    func byUpdatingPriority(_ priority: CTVFLPriority) -> CTVFLGenericPredicate
    
    func opcodes(
        forOrientation orientation: CTVFLConstraintOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLOptions
    ) -> [CTVFLOpcode]
    
    func toCTVFLGenericPredicate() -> CTVFLGenericPredicate
}

// MARK: - Updating Predication's Priority
public func ~ <P: CTVFLPredicating>(lhs: P, rhs: CTVFLPriority) -> CTVFLGenericPredicate {
    return lhs.byUpdatingPriority(rhs)
}

public func ~ <P: CTVFLPredicating>(lhs: P, rhs: Int) -> CTVFLGenericPredicate {
    return lhs.byUpdatingPriority(CTVFLPriority(Float(rhs)))
}

public func ~ <P: CTVFLPredicating>(lhs: P, rhs: Float) -> CTVFLGenericPredicate {
    return lhs.byUpdatingPriority(CTVFLPriority(rhs))
}

public func ~ <P: CTVFLPredicating>(lhs: P, rhs: Double) -> CTVFLGenericPredicate {
    return lhs.byUpdatingPriority(CTVFLPriority(Float(rhs)))
}

public func ~ <P: CTVFLPredicating>(lhs: P, rhs: CGFloat) -> CTVFLGenericPredicate {
    return lhs.byUpdatingPriority(CTVFLPriority(Float(rhs)))
}

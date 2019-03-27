//
//  CTVFLGenericPredicate.swift
//  CTVFL
//
//  Created on 2019/3/26.
//


public enum CTVFLGenericPredicate: CTVFLPredicating, Equatable {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithConstant
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    case constant(CTVFLConstantPredicate)
    case layoutable(CTVFLLayoutablePredicate)
    
    public func byUpdatingPriority(_ priority: CTVFLPriority)
        -> CTVFLGenericPredicate
    {
        switch self {
        case let .constant(constant):
            return constant.byUpdatingPriority(priority)
        case let .layoutable(layoutable):
            return layoutable.byUpdatingPriority(priority)
        }
    }
    
    public func opcodes(
        forOrientation orientation: CTVFLConstraintOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLOptions
        ) -> [CTVFLOpcode]
    {
        switch self {
        case let .constant(constant):
            return constant.opcodes(
                forOrientation: orientation,
                forObject: object,
                withOptions: options
            )
        case let .layoutable(layoutable):
            return layoutable.opcodes(
                forOrientation: orientation,
                forObject: object,
                withOptions: options
            )
        }
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLGenericPredicate {
        return self
    }
}

//
//  CTVFLGenericPredicate.swift
//  CTVFL
//
//  Created on 2019/3/26.
//


public enum CTVFLGenericPredicate: CTVFLPredicating, Equatable {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias SyntaxOperableForm = CTVFLSyntaxOperableFormConstant
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
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
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLFormatOptions,
        withContext context: CTVFLEvaluationContext
        )
    {
        switch self {
        case let .constant(constant):
            return constant.generateOpcodes(
                forOrientation: orientation,
                forObject: object,
                withOptions: options,
                withContext: context
            )
        case let .layoutable(layoutable):
            return layoutable.generateOpcodes(
                forOrientation: orientation,
                forObject: object,
                withOptions: options,
                withContext: context
            )
        }
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLGenericPredicate {
        return self
    }
}

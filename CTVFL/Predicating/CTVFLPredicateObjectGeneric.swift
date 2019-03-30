//
//  CTVFLPredicateObjectGeneric.swift
//  CTVFL
//
//  Created on 2019/3/26.
//


public enum CTVFLPredicateObjectGeneric: CTVFLPredicating, Equatable {
    case constant(CTVFLPredicateObjectConstant)
    case layoutable(CTVFLPredicateObjectLayoutable)
    
    public func byUpdatingPriority(_ priority: CTVFLPriority)
        -> CTVFLPredicateObjectGeneric
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
    
    public func toCTVFLGenericPredicate() -> CTVFLPredicateObjectGeneric {
        return self
    }
}

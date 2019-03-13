//
//  CTVFLVariantPredicateObject.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

public enum CTVFLVariantPredicateObject: Equatable {
    case constant(CTVFLConstant)
    case variable(CTVFLVariable)
    
    public func makePrimitiveVisualFormat(
        with inlineContext: CTVFLInlineContext
        ) -> String
    {
        switch self {
        case let .constant(c):
            return c.description
        case let .variable(v):
            return inlineContext._name(forVariable: v)
        }
    }
    
    public static func == (
        lhs: CTVFLVariantPredicateObject,
        rhs: CTVFLVariantPredicateObject
        ) -> Bool
    {
        switch (lhs, rhs) {
        case let (.constant(lhs), .constant(rhs)):
            return lhs == rhs
        case let (.variable(lhs), .variable(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

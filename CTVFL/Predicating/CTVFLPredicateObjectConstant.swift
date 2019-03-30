//
//  CTVFLPredicateObjectConstant.swift
//  CTVFL
//
//  Created on 2019/3/26.
//

import CoreGraphics

public struct CTVFLPredicateObjectConstant: CTVFLPredicating,
    CTVFLAssociableOperand,
    Equatable
{
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsConstant
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsConstant
    public typealias HeadAttribute = CTVFLSyntaxAttributeConstant
    public typealias TailAttribute = CTVFLSyntaxAttributeConstant
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    internal let _constant: CTVFLConstant
    
    internal let _relation: CTVFLLayoutRelation
    
    internal let _priority: CTVFLPriority
    
    internal init(
        constant: CTVFLConstant,
        relation: CTVFLLayoutRelation,
        priority: CTVFLPriority = .required
        )
    {
        _constant = constant
        _relation = relation
        _priority = priority
    }
    
    public func byUpdatingPriority(_ priority: CTVFLPriority)
        -> CTVFLPredicateObjectGeneric
    {
        return .constant(
            .init(
                constant: _constant,
                relation: _relation,
                priority: priority
            )
        )
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLPredicateObjectGeneric {
        return .constant(self)
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        return generateOpcodes(forOrientation: orientation, forObject: .position, withOptions: options, withContext: context)
    }
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLFormatOptions,
        withContext context: CTVFLEvaluationContext
        )
    {
        switch object {
        case .dimension:
            let attribute = _attribute(forOrientation: orientation)
            context._ensureOpcodesTailElements(6)
            context._appendOpcode(.push)
            context._appendOpcode(.moveFirstAttribute(attribute))
            context._appendOpcode(.moveConstant(CGFloat(_constant.rawValue)))
            context._appendOpcode(.moveRelation(_relation))
            context._appendOpcode(.movePriority(_priority))
            context._appendOpcode(.pop)
        case .position:
            context._ensureOpcodesTailElements(5)
            context._appendOpcode(.push)
            context._appendOpcode(.moveConstant(CGFloat(_constant.rawValue)))
            context._appendOpcode(.moveRelation(_relation))
            context._appendOpcode(.movePriority(_priority))
            context._appendOpcode(.pop)
        }
    }
    
    internal func _attribute(forOrientation orientation: CTVFLOrientation)
        -> CTVFLLayoutAttribute
    {
        switch orientation {
        case .horizontal:   return .width
        case .vertical:     return .height
        @unknown default:   fatalError()
        }
    }
}

extension CTVFLPredicateObjectConstant: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(constant: CTVFLConstant(rawValue: Float(value)), relation: .equal)
    }
}

extension CTVFLPredicateObjectConstant: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(constant: CTVFLConstant(rawValue: Float(value)), relation: .equal)
    }
}

public prefix func <= <P: CTVFLExpressibleByConstantLiteral>(predicate: P) -> CTVFLPredicateObjectConstant {
    return .init(constant: P._makeConstant(predicate), relation: .lessThanOrEqual)
}

public prefix func >= <P: CTVFLExpressibleByConstantLiteral>(predicate: P) -> CTVFLPredicateObjectConstant {
    return .init(constant: P._makeConstant(predicate), relation: .greaterThanOrEqual)
}

public prefix func == <P: CTVFLExpressibleByConstantLiteral>(predicate: P) -> CTVFLPredicateObjectConstant {
    return .init(constant: P._makeConstant(predicate), relation: .equal)
}

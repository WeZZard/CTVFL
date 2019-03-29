//
//  CTVFLConstantPredicate.swift
//  CTVFL
//
//  Created on 2019/3/26.
//

import CoreGraphics

public struct CTVFLConstantPredicate: CTVFLPredicating, CTVFLConstantOperand, Equatable {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormConstant
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
        -> CTVFLGenericPredicate
    {
        return .constant(
            .init(
                constant: _constant,
                relation: _relation,
                priority: priority
            )
        )
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLGenericPredicate {
        return .constant(self)
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withContext context: CTVFLEvaluationContext) {
        return generateOpcodes(forOrientation: orientation, forObject: .position, withOptions: options, withContext: context)
    }
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLOptions,
        withContext context: CTVFLEvaluationContext
        )
    {
        let layoutAttributeOrNil = _layoutAttribute(forOrientation: orientation, forObject: object)
        context._ensureOpcodesTailElements(4)
        if let layoutAttribute = layoutAttributeOrNil {
            context._appendOpcode(.moveAttribute(layoutAttribute))
        }
        context._appendOpcode(.moveConstant(_constant))
        context._appendOpcode(.moveRelation(_relation))
        context._appendOpcode(.movePriority(_priority))
    }
    
    internal func _layoutAttribute(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject
        ) -> CTVFLLayoutAttribute?
    {
        switch object {
        case .dimension:
            switch orientation {
            case .horizontal:   return .width
            case .vertical:     return .height
            @unknown default:   fatalError()
            }
        case .position:
            return nil
        }
    }
}

extension CTVFLConstantPredicate: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(constant: CTVFLConstant(rawValue: Float(value)), relation: .equal)
    }
}

extension CTVFLConstantPredicate: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Float
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(constant: CTVFLConstant(rawValue: Float(value)), relation: .equal)
    }
}

public prefix func <= <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLConstantPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .lessThanOrEqual)
}

public prefix func >= <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLConstantPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .greaterThanOrEqual)
}

public prefix func == <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLConstantPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .equal)
}

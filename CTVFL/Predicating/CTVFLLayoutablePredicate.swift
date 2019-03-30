//
//  CTVFLLayoutablePredicate.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

public struct CTVFLLayoutablePredicate: CTVFLPredicating, Equatable {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias SyntaxOperableForm = CTVFLSyntaxOperableFormConstant
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    internal var _layoutRelation: CTVFLLayoutRelation {
        switch _relation {
        case .equal:                return .equal
        case .greaterThanOrEqual:   return .greaterThanOrEqual
        case .lessThanOrEqual:      return .lessThanOrEqual
        @unknown default:           fatalError()
        }
    }
    
    internal let _priority: CTVFLPriority
    
    internal let _relation: CTVFLLayoutRelation
    
    internal let _layoutable: CTVFLLayoutable
    
    internal init(
        layoutable: CTVFLLayoutable,
        relation: CTVFLLayoutRelation,
        priority: CTVFLPriority = .required
        )
    {
        _layoutable = layoutable
        _relation = relation
        _priority = priority
    }
    
    public func byUpdatingPriority(_ priority: CTVFLPriority)
        -> CTVFLGenericPredicate
    {
        return .layoutable(
            .init(
                layoutable: _layoutable,
                relation: _relation,
                priority: priority
            )
        )
    }
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLFormatOptions,
        withContext context: CTVFLEvaluationContext
        )
    {
        let layoutAttributeOrNil = _layoutAttribute(forOrientation: orientation, forObject: object)
        
        context._ensureOpcodesTailElements(5)
        if let layoutAttribute = layoutAttributeOrNil {
            context._appendOpcode(.moveAttribute(layoutAttribute))
        }
        context._appendOpcode(.moveItem(.layoutable(_layoutable)))
        if let layoutAttribute = layoutAttributeOrNil {
            context._appendOpcode(.moveAttribute(layoutAttribute))
        }
        context._appendOpcode(.moveRelation(_layoutRelation))
        context._appendOpcode(.movePriority(_priority))
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLGenericPredicate {
        return .layoutable(self)
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

// MARK: - Compositing Predicate
public prefix func <= <P: CTVFLLayoutableConvertible>(predicate: P) -> CTVFLLayoutablePredicate {
    return .init(layoutable: P._makeLayoutable(predicate), relation: .greaterThanOrEqual)
}

public prefix func >= <P: CTVFLLayoutableConvertible>(predicate: P) -> CTVFLLayoutablePredicate {
    return .init(layoutable: P._makeLayoutable(predicate), relation: .greaterThanOrEqual)
}

public prefix func == <P: CTVFLLayoutableConvertible>(predicate: P) -> CTVFLLayoutablePredicate {
    return .init(layoutable: P._makeLayoutable(predicate), relation: .equal)
}

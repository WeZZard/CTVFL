//
//  CTVFLLayoutablePredicate.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

public struct CTVFLLayoutablePredicate: CTVFLPredicating, Equatable {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithConstant
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    internal var _layoutRelation: CTVFLLayoutRelation {
        switch _relation {
        case .equal:                return .equal
        case .greaterThanOrEqual:   return .greaterThanOrEqual
        case .lessThanOrEqual:      return .lessThanOrEqual
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
    
    public func opCodes(
        forOrientation orientation: CTVFLConstraintOrientation,
        forObject object: CTVFLPredicatedObject,
        withOptions options: CTVFLOptions
        ) -> [CTVFLOpCode]
    {
        let layoutAttribute = _layoutAttribute(forOrientation: orientation, forObject: object)
        return [
            layoutAttribute.map({.moveAttribute($0)}),
            .moveItem(.layoutable(_layoutable)),
            layoutAttribute.map({.moveAttribute($0)}),
            .moveRelation(_layoutRelation),
            .movePriority(_priority),
        ].compactMap({$0})
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLGenericPredicate {
        return .layoutable(self)
    }
    
    internal func _layoutAttribute(
        forOrientation orientation: CTVFLConstraintOrientation,
        forObject object: CTVFLPredicatedObject
        ) -> CTVFLLayoutAttribute?
    {
        switch object {
        case .dimension:
            switch orientation {
            case .horizontal:   return .width
            case .vertical:     return .height
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

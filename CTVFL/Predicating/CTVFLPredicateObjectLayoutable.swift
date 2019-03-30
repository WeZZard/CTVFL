//
//  CTVFLPredicateObjectLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

public struct CTVFLPredicateObjectLayoutable: CTVFLPredicating, Equatable {
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
        -> CTVFLPredicateObjectGeneric
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
        precondition(object == .dimension)
        
        let layoutAttribute = _attribute(forOrientation: orientation)
        
        context._ensureOpcodesTailElements(7)
        context._appendOpcode(.push)
        context._appendOpcode(.moveFirstAttribute(layoutAttribute))
        context._appendOpcode(.moveSecondItem(.layoutable(_layoutable)))
        context._appendOpcode(.moveSecondAttribute(layoutAttribute))
        context._appendOpcode(.moveRelation(_relation))
        context._appendOpcode(.movePriority(_priority))
        context._appendOpcode(.pop)
    }
    
    public func toCTVFLGenericPredicate() -> CTVFLPredicateObjectGeneric {
        return .layoutable(self)
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

// MARK: - Compositing Predicate
public prefix func <= (predicate: CTVFLView) -> CTVFLPredicateObjectLayoutable {
    return .init(layoutable: CTVFLView._makeLayoutable(predicate), relation: .lessThanOrEqual)
}

public prefix func >= (predicate: CTVFLView) -> CTVFLPredicateObjectLayoutable {
    return .init(layoutable: CTVFLView._makeLayoutable(predicate), relation: .greaterThanOrEqual)
}

public prefix func == (predicate: CTVFLView) -> CTVFLPredicateObjectLayoutable {
    return .init(layoutable: CTVFLView._makeLayoutable(predicate), relation: .equal)
}

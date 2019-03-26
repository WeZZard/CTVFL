//
//  CTVFLPredicate.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public protocol CTVFLPredicating {
    func _toCTVFLPredicate() -> CTVFLPredicate
}

public struct CTVFLPredicate: CTVFLPredicating, Equatable, CTVFLOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithConstant
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    internal enum _Relation: CustomStringConvertible {
        case equal
        case greaterThanOrEqual
        case lessThanOrEqual
        
        var description: String {
            switch self {
            case .equal:                return "=="
            case .greaterThanOrEqual:    return ">="
            case .lessThanOrEqual:      return "<="

            }
        }
    }
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .pushAttribute(_layoutAttribute(for: orientation)),
                .pushRelation(_layoutRelation)
            ],
            _predicate.opCodes(for: orientation)
        ].flatMap({$0})
    }
    
    internal func _layoutAttribute(for orientation: CTVFLConstraintOrientation)
        -> LayoutAttribute
    {
        switch orientation {
        case .horizontal:   return .width
        case .vertical:     return .height
        }
    }
    
    internal var _layoutRelation: LayoutRelation {
        switch _relation {
        case .equal:                return .equal
        case .greaterThanOrEqual:   return .greaterThanOrEqual
        case .lessThanOrEqual:      return .lessThanOrEqual
        }
    }
    
    internal let _priority: Priority
    
    internal let _relation: _Relation
    
    internal let _predicate: CTVFLWherePredicateContent
    
    internal init(
        predicate: CTVFLWherePredicateContent,
        relation: _Relation,
        priority: Priority
        )
    {
        _predicate = predicate
        _relation = relation
        _priority = priority
    }
    
    internal init(
        layoutable: CTVFLLayoutable,
        relation: _Relation,
        priority: Priority = .required
        )
    {
        self.init(
            predicate: .layoutable(layoutable),
            relation: relation,
            priority: priority
        )
    }
    
    internal init(
        constant: CTVFLConstant,
        relation: _Relation,
        priority: Priority = .required
        )
    {
        self.init(
            predicate: .constant(constant),
            relation: relation,
            priority: priority
        )
    }
    
    internal func _byUpdatingPriority(_ priority: Priority)
        -> CTVFLPredicate
    {
        return .init(
            predicate: _predicate,
            relation: _relation,
            priority: priority
        )
    }
    
    public func _toCTVFLPredicate() -> CTVFLPredicate {
        return self
    }
}

// MARK: - Compositing Predicate
public prefix func <= <P: CTVFLLayoutableConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(layoutable: P._makeLayoutable(predicate), relation: .greaterThanOrEqual)
}

public prefix func <= <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .lessThanOrEqual)
}

public prefix func >= <P: CTVFLLayoutableConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(layoutable: P._makeLayoutable(predicate), relation: .greaterThanOrEqual)
}

public prefix func >= <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .greaterThanOrEqual)
}

public prefix func == <P: CTVFLLayoutableConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(layoutable: P._makeLayoutable(predicate), relation: .equal)
}

public prefix func == <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .equal)
}

// MARK: - Updating Predication's Priority
public func ~ (lhs: CTVFLPredicate, rhs: Priority) -> CTVFLPredicate {
    return lhs._byUpdatingPriority(rhs)
}

public func ~ (lhs: CTVFLPredicate, rhs: Int) -> CTVFLPredicate {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

public func ~ (lhs: CTVFLPredicate, rhs: Float) -> CTVFLPredicate {
    return lhs._byUpdatingPriority(Priority(rhs))
}

public func ~ (lhs: CTVFLPredicate, rhs: Double) -> CTVFLPredicate {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

public func ~ (lhs: CTVFLPredicate, rhs: CGFloat) -> CTVFLPredicate {
    return lhs._byUpdatingPriority(Priority(Float(rhs)))
}

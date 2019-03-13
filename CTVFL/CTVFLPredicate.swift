//
//  CTVFLPredicate.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

public protocol CTVFLPredicating {
    func _toCTVFLPredicate() -> CTVFLPredicate
}

public struct CTVFLPredicate: CTVFLPredicating, CTVFLSpaceableLexicon,
    Equatable
{
    public typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    public typealias _LastLexiconType = CTVFLLexiconConstantType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
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
    
    internal let _priority: Priority
    
    internal let _relation: _Relation
    
    internal let _predicate: CTVFLVariantPredicateObject
    
    internal init(
        predicate: CTVFLVariantPredicateObject,
        relation: _Relation,
        priority: Priority
        )
    {
        _predicate = predicate
        _relation = relation
        _priority = priority
    }
    
    internal init(
        variable: CTVFLVariable,
        relation: _Relation,
        priority: Priority = .required
        )
    {
        self.init(
            predicate: .variable(variable),
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
    
    public func makePrimitiveVisualFormat(
        with inlineContext: CTVFLInlineContext
        ) -> String
    {
        let relation = _relation.description
        let predicate = _predicate.makePrimitiveVisualFormat(
            with: inlineContext
        )
        if _priority != .required {
            return "\(relation)\(predicate)@\(_priority.rawValue)"
        } else {
            return "\(relation)\(predicate)"
        }
    }
    
    public static func == (lhs: CTVFLPredicate, rhs: CTVFLPredicate) -> Bool {
        return lhs._predicate == rhs._predicate
            && lhs._priority == rhs._priority
            && lhs._relation == rhs._relation
    }
}

// MARK: - Compositing Predicate
public prefix func <= <P: CTVFLVariableConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(variable: P._makeVariable(predicate), relation: .greaterThanOrEqual)
}

public prefix func <= <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .lessThanOrEqual)
}

public prefix func >= <P: CTVFLVariableConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(variable: P._makeVariable(predicate), relation: .greaterThanOrEqual)
}

public prefix func >= <P: CTVFLConstantConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(constant: P._makeConstant(predicate), relation: .greaterThanOrEqual)
}

public prefix func == <P: CTVFLVariableConvertible>(predicate: P) -> CTVFLPredicate {
    return .init(variable: P._makeVariable(predicate), relation: .equal)
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


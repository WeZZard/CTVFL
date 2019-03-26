//
//  CTVFL.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - Make and Install Constraint Group
@discardableResult
public func constrain(
    toReplace gruop: CTVFLConstraintGroup? = nil,
    using closure: () -> Void
    ) -> CTVFLConstraintGroup
{
    let repacingGroup = gruop ?? CTVFLConstraintGroup()
    let transaction = _CTVFLTransaction.push()
    closure()
    let constraints = transaction.constraints
    _CTVFLTransaction.pop()
    repacingGroup._replaceConstraints(constraints)
    return repacingGroup
}

// MARK: - Building Inline VFL Block
@discardableResult
public func withVFL<T: CTVFLPopulatableOperand>(
    V description: @autoclosure ()-> T,
    options: VFLOptions = []
    ) -> [Constraint] where
    T.LeadingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary,
    T.TrailingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary
{
    let operand = description()
    let constraints = operand.makeConstraints(
        orientation: .vertical,
        options: options
    )
    return constraints
}

@discardableResult
public func withVFL<T: CTVFLPopulatableOperand>(
    H description: @autoclosure ()-> T,
    options: VFLOptions = []
    ) -> [Constraint] where
    T.LeadingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary,
    T.TrailingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary
{
    let operand = description()
    let constraints = operand.makeConstraints(
        orientation: .horizontal,
        options: options
    )
    return constraints
}

// MARK: Oeprators
precedencegroup CTVFLPriorityModifyPrecedence {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: AssignmentPrecedence
}

infix operator ~ : CTVFLPriorityModifyPrecedence

prefix operator <=

prefix operator >=

prefix operator ==

prefix operator |-

postfix operator -|

prefix operator |

postfix operator |


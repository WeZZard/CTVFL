//
//  WithVFL.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


@discardableResult
public func withVFL<T: CTVFLOperand & CTVFLEvaluatableSyntax>(
    V description: @autoclosure ()-> T,
    options: CTVFLOptions = []
    ) -> [CTVFLConstraint] where
    T.LeadingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary,
    T.TrailingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary
{
    let constraints = description().makeConstraints(
        orientation: .vertical,
        options: options
    )
    if let transaction = _CTVFLTransaction.shared {
        transaction.pushConstraints(constraints)
    }
    return constraints
}

@discardableResult
public func withVFL<T: CTVFLOperand & CTVFLEvaluatableSyntax>(
    H description: @autoclosure ()-> T,
    options: CTVFLOptions = []
    ) -> [CTVFLConstraint] where
    T.LeadingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary,
    T.TrailingLayoutBoundary == CTVFLSyntaxHasLayoutBoundary
{
    let constraints = description().makeConstraints(
        orientation: .horizontal,
        options: options
    )
    if let transaction = _CTVFLTransaction.shared {
        transaction.pushConstraints(constraints)
    }
    return constraints
}

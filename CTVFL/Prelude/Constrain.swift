//
//  CTVFL.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//


@discardableResult
public func constrain(
    toReplace gruop: CTVFLConstraintGroup? = nil,
    using closure: () -> Void
    ) -> CTVFLConstraintGroup
{
    let repacingGroup = gruop ?? CTVFLConstraintGroup()
    let transaction = _CTVFLTransaction.push()
    closure()
    let constraints = transaction.handlers
    _CTVFLTransaction.pop()
    repacingGroup._replaceConstraintHandlers(constraints)
    return repacingGroup
}
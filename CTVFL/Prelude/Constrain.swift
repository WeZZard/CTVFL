//
//  CTVFL.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//


@discardableResult
@inlinable
public func constrain(
    toReplace gruop: CTVFLConstraintGroup? = nil,
    using closure: () -> Void
    ) -> CTVFLConstraintGroup
{
    let repacingGroup = gruop ?? CTVFLConstraintGroup()
    CTVFLTransaction.begin()
    closure()
    let constraints = CTVFLTransaction.constraints
    CTVFLTransaction.commit()
    let handlers = _CTVFLConstraintHandler.makeHandlers(
        constraints: constraints
    )
    repacingGroup._replaceConstraintHandlers(handlers)
    return repacingGroup
}

//
//  WithVFL.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


@discardableResult
public func withVFL<S: CTVFLOperand & CTVFLConstraintsPopulatableSyntax>(
    V syntax: @autoclosure ()-> S,
    options: CTVFLFormatOptions = []
    ) -> [CTVFLConstraint] where
    S.HeadBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement,
    S.TailBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
{
    let constraints = syntax().makeConstraints(
        orientation: .vertical,
        options: options
    )
    CTVFLTransaction.addConstraints(constraints)
    return constraints
}

@discardableResult
public func withVFL<S: CTVFLOperand & CTVFLConstraintsPopulatableSyntax>(
    H syntax: @autoclosure ()-> S,
    options: CTVFLFormatOptions = []
    ) -> [CTVFLConstraint] where
    S.HeadBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement,
    S.TailBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
{
    let constraints = syntax().makeConstraints(
        orientation: .horizontal,
        options: options
    )
    CTVFLTransaction.addConstraints(constraints)
    return constraints
}

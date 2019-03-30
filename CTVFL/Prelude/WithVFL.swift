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
    ) -> (S, [CTVFLConstraint]) where
    S.HeadBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment,
    S.TailBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
{
    let generatedSyntax = syntax()
    let constraints = generatedSyntax.makeConstraints(
        orientation: .vertical,
        options: options
    )
    CTVFLTransaction.addConstraints(constraints)
    return (generatedSyntax, constraints)
}

@discardableResult
public func withVFL<S: CTVFLOperand & CTVFLConstraintsPopulatableSyntax>(
    H syntax: @autoclosure ()-> S,
    options: CTVFLFormatOptions = []
    ) -> (S, [CTVFLConstraint]) where
    S.HeadBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment,
    S.TailBoundary == CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
{
    let generatedSyntax = syntax()
    let constraints = generatedSyntax.makeConstraints(
        orientation: .horizontal,
        options: options
    )
    CTVFLTransaction.addConstraints(constraints)
    return (generatedSyntax, constraints)
}

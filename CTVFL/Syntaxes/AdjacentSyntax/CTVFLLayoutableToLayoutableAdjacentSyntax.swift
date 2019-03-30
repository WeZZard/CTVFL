//
//  CTVFLLayoutableToLayoutableAdjacentSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view1 | view2`
///
public struct CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociatedAdjacentSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

public func | <Lhs: CTVFLExpressibleByViewLiteral, Rhs: CTVFLExpressibleByViewLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs, Rhs: CTVFLExpressibleByViewLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs: CTVFLExpressibleByViewLiteral, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

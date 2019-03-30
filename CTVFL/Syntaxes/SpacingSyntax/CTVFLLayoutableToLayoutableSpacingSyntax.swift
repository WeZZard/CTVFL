//
//  CTVFLLayoutableToLayoutableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view1 - view2`
///
public struct CTVFLLayoutableToLayoutableSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociatedSpacingSyntax where
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

public func - <Lhs: CTVFLExpressibleByViewLiteral, Rhs: CTVFLExpressibleByViewLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs: CTVFLExpressibleByViewLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs: CTVFLExpressibleByViewLiteral, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: lhs, rhs: rhs)
}

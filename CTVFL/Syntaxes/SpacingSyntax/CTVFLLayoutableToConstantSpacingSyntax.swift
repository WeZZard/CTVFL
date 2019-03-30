//
//  CTVFLLayoutableToConstantSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view - n`
///
public struct CTVFLLayoutableToConstantSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociableOperand>:
    CTVFLAssociableOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociableSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeConstant,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func - <Lhs: CTVFLExpressibleByViewLiteral, Rhs: CTVFLExpressibleByConstantLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs, Rhs: CTVFLExpressibleByConstantLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs: CTVFLExpressibleByViewLiteral, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: lhs, rhs: rhs)
}

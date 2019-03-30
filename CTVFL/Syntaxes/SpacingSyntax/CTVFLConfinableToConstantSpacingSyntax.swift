//
//  CTVFLConfinableToConstantSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `layoutGuide - n`
///
public struct CTVFLConfinableToConstantSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociableOperand>:
    CTVFLAssociableOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociableSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConfinment,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeConstant,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func - <Lhs: CTVFLExpressibleByLayoutGuideLiteral, Rhs: CTVFLExpressibleByConstantLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<CTVFLConfinable, CTVFLConstant> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: Lhs._makeConfinable(lhs), rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs, Rhs: CTVFLExpressibleByConstantLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<Lhs, CTVFLConstant> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs: CTVFLExpressibleByLayoutGuideLiteral, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<CTVFLConfinable, Rhs> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: Lhs._makeConfinable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<Lhs, Rhs> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: lhs, rhs: rhs)
}

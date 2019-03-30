//
//  CTVFLConfinableToEdgeSpaceSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//


public struct CTVFLConfinableToEdgeSpaceSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLEdgeSpaceOperand>:
    CTVFLAssociableOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToEdgeSpaceSpacingSyntax where
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

public func - <Lhs: CTVFLExpressibleByLayoutGuideLiteral, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToEdgeSpaceSpacingSyntax<CTVFLConfinable, Rhs> {
    return CTVFLConfinableToEdgeSpaceSpacingSyntax(lhs: Lhs._makeConfinable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToEdgeSpaceSpacingSyntax<Lhs, Rhs> {
    return CTVFLConfinableToEdgeSpaceSpacingSyntax(lhs: lhs, rhs: rhs)
}

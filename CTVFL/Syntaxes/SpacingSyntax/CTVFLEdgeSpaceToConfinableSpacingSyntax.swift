//
//  CTVFLEdgeSpaceToConfinableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//


public struct CTVFLEdgeSpaceToConfinableSpacingSyntax<Lhs: CTVFLEdgeSpaceOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLEdgeSpaceToAssociatedSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConstant,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeConfinment,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func - <Lhs, Rhs: CTVFLExpressibleByLayoutGuideLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLEdgeSpaceToConfinableSpacingSyntax<Lhs, CTVFLConfinable> {
    return CTVFLEdgeSpaceToConfinableSpacingSyntax(lhs: lhs, rhs: Rhs._makeConfinable(rhs))
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLEdgeSpaceToConfinableSpacingSyntax<Lhs, Rhs> {
    return CTVFLEdgeSpaceToConfinableSpacingSyntax(lhs: lhs, rhs: rhs)
}

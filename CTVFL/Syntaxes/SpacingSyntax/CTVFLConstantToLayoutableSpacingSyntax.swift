//
//  CTVFLConstantToLayoutableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `n - view`
///
public struct CTVFLConstantToLayoutableSpacingSyntax<Lhs: CTVFLAssociableOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociableToAssociatedSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConstant,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func - <Lhs, Rhs: CTVFLExpressibleByViewLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLConstantToLayoutableSpacingSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSpacingSyntax<Lhs, Rhs> {
    return CTVFLConstantToLayoutableSpacingSyntax(lhs: lhs, rhs: rhs)
}

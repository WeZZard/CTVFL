//
//  CTVFLLayoutableToConfinableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view - layoutGuide`
///
public struct CTVFLLayoutableToConfinableSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociatedSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeConfinment,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func - <Lhs: CTVFLExpressibleByViewLiteral, Rhs: CTVFLExpressibleByLayoutGuideLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<CTVFLLayoutable, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConfinable(rhs))
}

public func - <Lhs, Rhs: CTVFLExpressibleByLayoutGuideLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<Lhs, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: lhs, rhs: Rhs._makeConfinable(rhs))
}

public func - <Lhs: CTVFLExpressibleByViewLiteral, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: lhs, rhs: rhs)
}

//
//  CTVFLLayoutableToConfinableAdjacentSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view | layoutGuide`
///
public struct CTVFLLayoutableToConfinableAdjacentSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociatedAdjacentSyntax where
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

public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

public func | <Lhs: CTVFLExpressibleByViewLiteral, Rhs: CTVFLExpressibleByLayoutGuideLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<CTVFLLayoutable, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConfinable(rhs))
}

public func | <Lhs, Rhs: CTVFLExpressibleByLayoutGuideLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<Lhs, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: lhs, rhs: Rhs._makeConfinable(rhs))
}

public func | <Lhs: CTVFLExpressibleByViewLiteral, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

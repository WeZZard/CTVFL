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

public func - (lhs: CTVFLView, rhs: CTVFLLayoutGuide) -> CTVFLLayoutableToConfinableSpacingSyntax<CTVFLLayoutable, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: CTVFLView._makeLayoutable(lhs), rhs: CTVFLLayoutGuide._makeConfinable(rhs))
}

public func - <Lhs>(lhs: Lhs, rhs: CTVFLLayoutGuide) -> CTVFLLayoutableToConfinableSpacingSyntax<Lhs, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: lhs, rhs: CTVFLLayoutGuide._makeConfinable(rhs))
}

public func - <Rhs>(lhs: CTVFLView, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: CTVFLView._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: lhs, rhs: rhs)
}

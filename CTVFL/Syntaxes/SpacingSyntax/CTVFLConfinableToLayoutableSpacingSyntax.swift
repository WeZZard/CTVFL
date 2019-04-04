//
//  CTVFLConfinableToLayoutableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `layoutGuide - view`
///
public struct CTVFLConfinableToLayoutableSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociatedSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConfinement,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func - (lhs: CTVFLLayoutGuide, rhs: CTVFLView) -> CTVFLConfinableToLayoutableSpacingSyntax<CTVFLConfinable, CTVFLLayoutable> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: CTVFLLayoutGuide._makeConfinable(lhs), rhs: CTVFLView._makeLayoutable(rhs))
}

public func - <Lhs>(lhs: Lhs, rhs: CTVFLView) -> CTVFLConfinableToLayoutableSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: lhs, rhs: CTVFLView._makeLayoutable(rhs))
}

public func - <Rhs>(lhs: CTVFLLayoutGuide, rhs: Rhs) -> CTVFLConfinableToLayoutableSpacingSyntax<CTVFLConfinable, Rhs> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: CTVFLLayoutGuide._makeConfinable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToLayoutableSpacingSyntax<Lhs, Rhs> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: lhs, rhs: rhs)
}

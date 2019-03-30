//
//  CTVFLConfinableToLayoutableAdjacentSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `layoutGuide | view1`
///
public struct CTVFLConfinableToLayoutableAdjacentSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociatedAdjacentSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConfinment,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
}

public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToLayoutableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLConfinableToLayoutableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

public func | (lhs: CTVFLLayoutGuide, rhs: CTVFLView) -> CTVFLConfinableToLayoutableAdjacentSyntax<CTVFLConfinable, CTVFLLayoutable> {
    return CTVFLConfinableToLayoutableAdjacentSyntax(lhs: CTVFLLayoutGuide._makeConfinable(lhs), rhs: CTVFLView._makeLayoutable(rhs))
}

public func | <Lhs>(lhs: Lhs, rhs: CTVFLView) -> CTVFLConfinableToLayoutableAdjacentSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLConfinableToLayoutableAdjacentSyntax(lhs: lhs, rhs: CTVFLView._makeLayoutable(rhs))
}

public func | <Rhs>(lhs: CTVFLLayoutGuide, rhs: Rhs) -> CTVFLConfinableToLayoutableAdjacentSyntax<CTVFLConfinable, Rhs> {
    return CTVFLConfinableToLayoutableAdjacentSyntax(lhs: CTVFLLayoutGuide._makeConfinable(lhs), rhs: rhs)
}

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
    Rhs.HeadAttribute == CTVFLSyntaxAttributeConfinement,
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    @inline(__always)
    public init(lhs: Lhs, rhs: Rhs) {
        self.lhs = lhs
        self.rhs = rhs
    }
}

@inlinable
public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

@inlinable
public func | (lhs: CTVFLView, rhs: CTVFLLayoutGuide) -> CTVFLLayoutableToConfinableAdjacentSyntax<CTVFLLayoutable, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: CTVFLView._makeLayoutable(lhs), rhs: CTVFLLayoutGuide._makeConfinable(rhs))
}

@inlinable
public func | <Lhs>(lhs: Lhs, rhs: CTVFLLayoutGuide) -> CTVFLLayoutableToConfinableAdjacentSyntax<Lhs, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: lhs, rhs: CTVFLLayoutGuide._makeConfinable(rhs))
}

@inlinable
public func | <Rhs>(lhs: CTVFLView, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: CTVFLView._makeLayoutable(lhs), rhs: rhs)
}

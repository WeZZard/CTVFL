//
//  CTVFLLayoutableToLayoutableAdjacentSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view1 | view2`
///
public struct CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociatedAdjacentSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeLayoutedObject,
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
public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

@inlinable
public func | (lhs: CTVFLView, rhs: CTVFLView) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: CTVFLView._makeLayoutable(lhs), rhs: CTVFLView._makeLayoutable(rhs))
}

@inlinable
public func | <Lhs>(lhs: Lhs, rhs: CTVFLView) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: CTVFLView._makeLayoutable(rhs))
}

@inlinable
public func | <Rhs>(lhs: CTVFLView, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: CTVFLView._makeLayoutable(lhs), rhs: rhs)
}

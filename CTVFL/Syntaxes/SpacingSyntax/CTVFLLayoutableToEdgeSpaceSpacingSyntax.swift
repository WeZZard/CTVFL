//
//  CTVFLLayoutableToEdgeSpaceSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//


public struct CTVFLLayoutableToEdgeSpaceSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLEdgeSpaceOperand>:
    CTVFLAssociableOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToEdgeSpaceSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeLayoutedObject,
    Rhs.HeadAttribute == CTVFLSyntaxAttributeConstant,
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
public func - <Rhs>(lhs: CTVFLView, rhs: Rhs) -> CTVFLLayoutableToEdgeSpaceSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToEdgeSpaceSpacingSyntax(lhs: CTVFLView._makeLayoutable(lhs), rhs: rhs)
}

@inlinable
public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToEdgeSpaceSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToEdgeSpaceSpacingSyntax(lhs: lhs, rhs: rhs)
}

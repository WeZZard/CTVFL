//
//  CTVFLEdgeSpaceToLayoutableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//


public struct CTVFLEdgeSpaceToLayoutableSpacingSyntax<Lhs: CTVFLEdgeSpaceOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLEdgeSpaceToAssociatedSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConstant,
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
public func - <Lhs>(lhs: Lhs, rhs: CTVFLView) -> CTVFLEdgeSpaceToLayoutableSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLEdgeSpaceToLayoutableSpacingSyntax(lhs: lhs, rhs: CTVFLView._makeLayoutable(rhs))
}

@inlinable
public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLEdgeSpaceToLayoutableSpacingSyntax<Lhs, Rhs> {
    return CTVFLEdgeSpaceToLayoutableSpacingSyntax(lhs: lhs, rhs: rhs)
}

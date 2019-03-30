//
//  CTVFLAssociatedToAssociatedAdjacentSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//

public protocol CTVFLAssociatedToAssociatedAdjacentSyntax:
    CTVFLAssociatedToAssociatedSyntax
{
    associatedtype HeadBoundary = LhsOperand.HeadBoundary
    associatedtype TailBoundary = RhsOperand.TailBoundary
    associatedtype HeadAttribute = LhsOperand.HeadAttribute
    associatedtype TailAttribute = RhsOperand.TailAttribute
    associatedtype HeadAssociativity = LhsOperand.HeadAssociativity
    associatedtype TailAssociativity = RhsOperand.TailAssociativity
}

extension CTVFLAssociatedToAssociatedAdjacentSyntax {
    @inline(__always)
    public static var usesSystemSpacing: Bool { return false }
}

//
//  CTVFLConstantToConfinableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `n - layoutGuide`
///
public struct CTVFLConstantToConfinableSpacingSyntax<Lhs: CTVFLAssociableOperand, Rhs: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociableToAssociatedSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConstant,
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
public func - <Lhs>(lhs: Lhs, rhs: CTVFLLayoutGuide) -> CTVFLConstantToConfinableSpacingSyntax<Lhs, CTVFLConfinable> {
    return CTVFLConstantToConfinableSpacingSyntax(lhs: lhs, rhs: CTVFLLayoutGuide._makeConfinable(rhs))
}

@inlinable
public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToConfinableSpacingSyntax<Lhs, Rhs> {
    return CTVFLConstantToConfinableSpacingSyntax(lhs: lhs, rhs: rhs)
}

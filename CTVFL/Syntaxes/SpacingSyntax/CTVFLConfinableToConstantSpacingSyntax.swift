//
//  CTVFLConfinableToConstantSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `layoutGuide - n`
///
public struct CTVFLConfinableToConstantSpacingSyntax<Lhs: CTVFLAssociatedOperand, Rhs: CTVFLAssociableOperand>:
    CTVFLAssociableOperand, CTVFLConstraintsPopulatableSyntax, CTVFLAssociatedToAssociableSpacingSyntax where
    Lhs.TailAttribute == CTVFLSyntaxAttributeConfinement,
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
public func - <Rhs: CTVFLExpressibleByConstantLiteral>(lhs: CTVFLLayoutGuide, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<CTVFLConfinable, CTVFLConstant> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: CTVFLLayoutGuide._makeConfinable(lhs), rhs: Rhs._makeConstant(rhs))
}

@inlinable
public func - <Lhs, Rhs: CTVFLExpressibleByConstantLiteral>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<Lhs, CTVFLConstant> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}

@inlinable
public func - <Rhs>(lhs: CTVFLLayoutGuide, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<CTVFLConfinable, Rhs> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: CTVFLLayoutGuide._makeConfinable(lhs), rhs: rhs)
}

@inlinable
public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<Lhs, Rhs> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: lhs, rhs: rhs)
}

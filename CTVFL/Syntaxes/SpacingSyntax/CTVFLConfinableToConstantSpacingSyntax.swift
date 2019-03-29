//
//  CTVFLConfinableToConstantSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `layoutGuide - n`
///
public struct CTVFLConfinableToConstantSpacingSyntax<Lhs: CTVFLConfinableOperand, Rhs: CTVFLConstantOperand>:
    CTVFLConstraintsPopulatableSyntax, CTVFLConstantOperand, _CTVFLBinarySyntax where
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormConstant
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Rhs.HeadAssociativity
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(2)
        context._appendOpcode(.push)
        context._appendOpcode(.moveAttribute(lhs.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.moveEvaluationSite(.secondItem))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
    }
}

public func - <Lhs: CTVFLConfinableConvertible, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<CTVFLConfinable, CTVFLConstant> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: Lhs._makeConfinable(lhs), rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<Lhs, CTVFLConstant> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs: CTVFLConfinableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<CTVFLConfinable, Rhs> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: Lhs._makeConfinable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToConstantSpacingSyntax<Lhs, Rhs> {
    return CTVFLConfinableToConstantSpacingSyntax(lhs: lhs, rhs: rhs)
}

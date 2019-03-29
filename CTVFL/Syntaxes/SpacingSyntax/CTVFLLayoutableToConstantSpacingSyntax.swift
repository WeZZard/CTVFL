//
//  CTVFLLayoutableToConstantSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view - n`
///
public struct CTVFLLayoutableToConstantSpacingSyntax<Lhs: CTVFLLayoutableOperand, Rhs: CTVFLConstantOperand>:
    CTVFLConstraintsPopulatableSyntax, CTVFLConstantOperand, _CTVFLBinarySyntax where
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormConstant
    public typealias HeadAssociativity = Lhs.HeadAssociativity
    public typealias TailAssociativity = Rhs.TailAssociativity
    
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

public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConstantSpacingSyntax(lhs: lhs, rhs: rhs)
}

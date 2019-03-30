//
//  CTVFLLeadingConstantSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `|-n`
///
public struct CTVFLLeadingConstantSyntax<O: CTVFLConstantOperand>:
    CTVFLOperand, CTVFLConstantOperand, _CTVFLLeadingSyntax where
    O.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias OperableForm = Operand.OperableForm
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Operand.TailAssociativity
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.push)
        context._appendOpcode(.moveItem(.container))
        context._appendOpcode(.moveAttribute(attributeForContainer(at: .lhs, forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
    }
}

public prefix func |- <Operand: CTVFLConstantConvertible>(operand: Operand) -> CTVFLLeadingConstantSyntax<CTVFLConstant> {
    return CTVFLLeadingConstantSyntax(operand: Operand._makeConstant(operand))
}

public prefix func |- <Operand>(operand: Operand) -> CTVFLLeadingConstantSyntax<Operand> {
    return CTVFLLeadingConstantSyntax(operand: operand)
}

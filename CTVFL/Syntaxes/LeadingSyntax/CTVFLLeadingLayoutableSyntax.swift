//
//  CTVFLLeadingLayoutableSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `|view`
///
public struct CTVFLLeadingLayoutableSyntax<O: CTVFLLayoutableOperand>:
    CTVFLConstraintsPopulatableSyntax, CTVFLLayoutableOperand, _CTVFLLeadingSyntax where
    O.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias OperableForm = Operand.OperableForm
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Operand.TailAssociativity
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(7)
        context._appendOpcode(.push)
        context._appendOpcode(.moveConstant(CTVFLConstant(rawValue: 0)))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.moveItem(.container))
        context._appendOpcode(.moveAttribute(attributeForContainer(at: .lhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveAttribute(operand.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveEvaluationSite(.secondItem))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.moveReturnValue(.secondItem))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

public prefix func | <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLLeadingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLLeadingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func | <Operand>(operand: Operand) -> CTVFLLeadingLayoutableSyntax<Operand> {
    return CTVFLLeadingLayoutableSyntax(operand: operand)
}

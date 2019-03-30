//
//  CTVFLTrailingLayoutableSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view|`
///
public struct CTVFLTrailingLayoutableSyntax<O: CTVFLLayoutableOperand>:
    CTVFLConstraintsPopulatableSyntax, CTVFLLayoutableOperand, _CTVFLTrailingSyntax where
    O.TailAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = Operand.OperableForm
    public typealias HeadAssociativity = Operand.HeadAssociativity
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsClosed
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.push)
        context._appendOpcode(.moveConstant(CTVFLConstant(rawValue: 0)))
        context._appendOpcode(.moveRelation(.equal))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(6)
        context._appendOpcode(.moveAttribute(operand.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveItem(.container))
        context._appendOpcode(.moveAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveReturnValue(.firstItem))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

public postfix func | <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLTrailingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLTrailingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func | <Operand>(operand: Operand) -> CTVFLTrailingLayoutableSyntax<Operand> {
    return CTVFLTrailingLayoutableSyntax(operand: operand)
}

//
//  CTVFLTrailingLayoutableWithSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view-|`
///
public struct CTVFLTrailingLayoutableWithSpacingSyntax<O: CTVFLLayoutableOperand>:
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
        context._ensureOpcodesTailElements(4)
        context._appendOpcode(.push)
        context._appendOpcode(.moveUsesSystemSpace(true))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.moveAttribute(operand.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(5)
        context._appendOpcode(.moveItem(.container))
        context._appendOpcode(.moveAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveReturnValue(.firstItem))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

public postfix func -| <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLTrailingLayoutableWithSpacingSyntax<CTVFLLayoutable> {
    return CTVFLTrailingLayoutableWithSpacingSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func -| <Operand>(operand: Operand) -> CTVFLTrailingLayoutableWithSpacingSyntax<Operand> {
    return CTVFLTrailingLayoutableWithSpacingSyntax(operand: operand)
}

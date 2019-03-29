//
//  CTVFLTrailingConstantSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `n-|`
///
public struct CTVFLTrailingConstantSyntax<O: CTVFLConstantOperand>:
    CTVFLOperand, CTVFLConstantOperand, _CTVFLTrailingSyntax where
    O.TailAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = Operand.OperableForm
    public typealias HeadAssociativity = Operand.HeadAssociativity
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsClosed
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withContext context: CTVFLEvaluationContext) {
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(5)
        context._appendOpcode(.moveItem(.container))
        context._appendOpcode(.moveAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveReturnValue(.firstItem))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

public postfix func -| <Operand: CTVFLConstantConvertible>(operand: Operand) -> CTVFLTrailingConstantSyntax<CTVFLConstant> {
    return CTVFLTrailingConstantSyntax(operand: Operand._makeConstant(operand))
}

public postfix func -| <Operand>(operand: Operand) -> CTVFLTrailingConstantSyntax<Operand> {
    return CTVFLTrailingConstantSyntax(operand: operand)
}

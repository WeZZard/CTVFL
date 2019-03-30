//
//  CTVFLTrailingLayoutableSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view|`
///
public struct CTVFLTrailingLayoutableSyntax<O: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLUnarySyntax where
    O.TailAttribute == CTVFLSyntaxAttributeLayoutedObject,
    O.TailAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias HeadBoundary = Operand.HeadBoundary
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
    public typealias HeadAttribute = Operand.HeadAttribute
    public typealias TailAttribute = CTVFLSyntaxAttributeConfinment
    public typealias HeadAssociativity = Operand.HeadAssociativity
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsClosed
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(7)
        context._appendOpcode(.moveFirstItemFromRetVal(.second))
        context._appendOpcode(.moveFirstAttribute(operand.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveSecondItem(.container))
        context._appendOpcode(.moveSecondAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

public postfix func | <Operand: CTVFLExpressibleByViewLiteral>(operand: Operand) -> CTVFLTrailingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLTrailingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func | <Operand>(operand: Operand) -> CTVFLTrailingLayoutableSyntax<Operand> {
    return CTVFLTrailingLayoutableSyntax(operand: operand)
}

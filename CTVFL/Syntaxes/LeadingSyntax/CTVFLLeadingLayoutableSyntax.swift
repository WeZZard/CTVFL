//
//  CTVFLLeadingLayoutableSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `|view`
///
public struct CTVFLLeadingLayoutableSyntax<O: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLUnarySyntax where
    O.HeadAttribute == CTVFLSyntaxAttributeLayoutedObject,
    O.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
    public typealias TailBoundary = Operand.TailBoundary
    public typealias HeadAttribute = CTVFLSyntaxAttributeConfinment
    public typealias TailAttribute = Operand.TailAttribute
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Operand.TailAssociativity
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.push)
        context._appendOpcode(.moveFirstItem(.container))
        context._appendOpcode(.moveFirstAttribute(attributeForContainer(at: .lhs, forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(5)
        context._appendOpcode(.moveSecondItemFromRetVal(.first))
        context._appendOpcode(.moveSecondAttribute(operand.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

public prefix func | <Operand: CTVFLExpressibleByViewLiteral>(operand: Operand) -> CTVFLLeadingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLLeadingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func | <Operand>(operand: Operand) -> CTVFLLeadingLayoutableSyntax<Operand> {
    return CTVFLLeadingLayoutableSyntax(operand: operand)
}

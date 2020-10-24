//
//  CTVFLTrailingLayoutableWithSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view-|`
///
public struct CTVFLTrailingLayoutableWithSpacingSyntax<O: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLUnarySyntax where
    O.TailAttribute == CTVFLSyntaxAttributeLayoutedObject,
    O.TailAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias HeadBoundary = Operand.HeadBoundary
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
    public typealias HeadAttribute = Operand.HeadAttribute
    public typealias TailAttribute = CTVFLSyntaxAttributeConfinement
    public typealias HeadAssociativity = Operand.HeadAssociativity
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsClosed
    
    public let operand: Operand
    
    @inline(__always)
    public init(operand: Operand) {
        self.operand = operand
    }
    
    @inlinable
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(8)
        context._appendOpcode(.moveLhsItemFromRetValLhsItem)
        context._appendOpcode(.moveRhsItemFromRetValRhsItem)
        context._appendOpcode(.moveFirstItemFromRetVal(.rhs))
        context._appendOpcode(.moveFirstAttribute(operand.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveSecondItem(.container))
        context._appendOpcode(.moveSecondAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveUsesSystemSpace(true))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

@inlinable
public postfix func -| (operand: CTVFLView) -> CTVFLTrailingLayoutableWithSpacingSyntax<CTVFLLayoutable> {
    return CTVFLTrailingLayoutableWithSpacingSyntax(operand: CTVFLView._makeLayoutable(operand))
}

@inlinable
public postfix func -| <Operand>(operand: Operand) -> CTVFLTrailingLayoutableWithSpacingSyntax<Operand> {
    return CTVFLTrailingLayoutableWithSpacingSyntax(operand: operand)
}

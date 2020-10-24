//
//  CTVFLLeadingLayoutableWithSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `|-view`
///
public struct CTVFLLeadingLayoutableWithSpacingSyntax<O: CTVFLAssociatedOperand>:
    CTVFLAssociatedOperand, CTVFLConstraintsPopulatableSyntax, CTVFLUnarySyntax where
    O.HeadAttribute == CTVFLSyntaxAttributeLayoutedObject,
    O.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
    public typealias TailBoundary = Operand.TailBoundary
    public typealias HeadAttribute = CTVFLSyntaxAttributeConfinement
    public typealias TailAttribute = Operand.TailAttribute
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Operand.TailAssociativity
    
    public let operand: Operand
    
    @inline(__always)
    public init(operand: Operand) {
        self.operand = operand
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.push)
        context._appendOpcode(.moveFirstItem(.container))
        context._appendOpcode(.moveFirstAttribute(attributeForContainer(at: .lhs, forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(8)
        context._appendOpcode(.moveLhsItemFromRetValLhsItem)
        context._appendOpcode(.moveRhsItemFromRetValRhsItem)
        context._appendOpcode(.moveSecondItemFromRetVal(.lhs))
        context._appendOpcode(.moveSecondAttribute(operand.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveUsesSystemSpace(true))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

@inlinable
public prefix func |- (operand: CTVFLView) -> CTVFLLeadingLayoutableWithSpacingSyntax<CTVFLLayoutable> {
    return CTVFLLeadingLayoutableWithSpacingSyntax(operand: CTVFLView._makeLayoutable(operand))
}

@inlinable
public prefix func |- <Operand>(operand: Operand) -> CTVFLLeadingLayoutableWithSpacingSyntax<Operand> {
    return CTVFLLeadingLayoutableWithSpacingSyntax(operand: operand)
}

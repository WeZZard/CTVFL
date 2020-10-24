//
//  CTVFLAssociableToAssociatedSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//

public protocol CTVFLAssociableToAssociatedSpacingSyntax: CTVFLBinarySyntax where
    LhsOperand: CTVFLAssociableOperand, RhsOperand: CTVFLAssociatedOperand
{
    associatedtype HeadBoundary = LhsOperand.HeadBoundary
    associatedtype TailBoundary = RhsOperand.TailBoundary
    associatedtype HeadAttribute = LhsOperand.HeadAttribute
    associatedtype TailAttribute = RhsOperand.TailAttribute
    associatedtype HeadAssociativity = LhsOperand.HeadAssociativity
    associatedtype TailAssociativity = RhsOperand.TailAssociativity
}

extension CTVFLAssociableToAssociatedSpacingSyntax {
    @inlinable
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(7)
        context._appendOpcode(.moveLhsItemFromRetValLhsItem)
        context._appendOpcode(.moveFirstItemFromRetVal(.lhs))
        context._appendOpcode(.moveFirstAttributeFromRetVal(.first))
        context._appendOpcode(.moveReleationFromRetVal)
        context._appendOpcode(.moveConstantFromRetVal)
        context._appendOpcode(.movePriorityFromRetVal)
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(5)
        context._appendOpcode(.moveRhsItemFromRetValRhsItem)
        context._appendOpcode(.moveSecondItemFromRetVal(.lhs))
        context._appendOpcode(.moveSecondAttribute(rhs.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

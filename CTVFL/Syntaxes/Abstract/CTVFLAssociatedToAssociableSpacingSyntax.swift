//
//  CTVFLAssociatedToAssociableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//

public protocol CTVFLAssociatedToAssociableSpacingSyntax: CTVFLBinarySyntax where
    LhsOperand: CTVFLAssociatedOperand, RhsOperand: CTVFLAssociableOperand
{
    associatedtype HeadBoundary = LhsOperand.HeadBoundary
    associatedtype TailBoundary = RhsOperand.TailBoundary
    associatedtype HeadAttribute = LhsOperand.HeadAttribute
    associatedtype TailAttribute = RhsOperand.TailAttribute
    associatedtype HeadAssociativity = LhsOperand.HeadAssociativity
    associatedtype TailAssociativity = RhsOperand.TailAssociativity
}

extension CTVFLAssociatedToAssociableSpacingSyntax {
    @inlinable
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.moveLhsItemFromRetValLhsItem)
        context._appendOpcode(.moveFirstItemFromRetVal(.rhs))
        context._appendOpcode(.moveFirstAttribute(lhs.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(5)
        context._appendOpcode(.moveRhsItemFromRetValRhsItem)
        context._appendOpcode(.moveReleationFromRetVal)
        context._appendOpcode(.moveConstantFromRetVal)
        context._appendOpcode(.movePriorityFromRetVal)
        context._appendOpcode(.pop)
    }
}

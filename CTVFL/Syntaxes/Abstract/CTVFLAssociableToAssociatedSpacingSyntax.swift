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
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(6)
        context._appendOpcode(.moveFirstItemFromRetVal(.first))
        context._appendOpcode(.moveFirstAttributeFromRetVal(.first))
        context._appendOpcode(.moveReleationFromRetVal)
        context._appendOpcode(.moveConstantFromRetVal)
        context._appendOpcode(.movePriorityFromRetVal)
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(4)
        context._appendOpcode(.moveSecondItemFromRetVal(.first))
        context._appendOpcode(.moveSecondAttribute(rhs.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

//
//  CTVFLAssociatedToEdgeSpaceSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//

public protocol CTVFLAssociatedToEdgeSpaceSpacingSyntax: CTVFLBinarySyntax where
    LhsOperand: CTVFLAssociatedOperand, RhsOperand: CTVFLEdgeSpaceOperand
{
    associatedtype HeadBoundary = LhsOperand.HeadBoundary
    associatedtype TailBoundary = RhsOperand.TailBoundary
    associatedtype HeadAttribute = LhsOperand.HeadAttribute
    associatedtype TailAttribute = RhsOperand.TailAttribute
    associatedtype HeadAssociativity = LhsOperand.HeadAssociativity
    associatedtype TailAssociativity = RhsOperand.TailAssociativity
}

extension CTVFLAssociatedToEdgeSpaceSpacingSyntax {
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(2)
        context._appendOpcode(.moveFirstItemFromRetVal(.second))
        context._appendOpcode(.moveFirstAttribute(lhs.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(7)
        context._appendOpcode(.moveSecondItemFromRetVal(.second))
        context._appendOpcode(.moveSecondAttributeFromRetVal(.second))
        context._appendOpcode(.moveReleationFromRetVal)
        context._appendOpcode(.moveConstantFromRetVal)
        context._appendOpcode(.movePriorityFromRetVal)
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

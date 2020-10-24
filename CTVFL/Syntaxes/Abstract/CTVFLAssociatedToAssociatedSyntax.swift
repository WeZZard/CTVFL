//
//  CTVFLAssociatedToAssociatedSyntax.swift
//  CTVFL
//
//  Created on 2019/3/30.
//

public protocol CTVFLAssociatedToAssociatedSyntax: CTVFLBinarySyntax
    where
    LhsOperand: CTVFLAssociatedOperand,
    RhsOperand: CTVFLAssociatedOperand
{
    static var usesSystemSpacing: Bool { get }
}

extension CTVFLAssociatedToAssociatedSyntax {
    @inlinable
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        let usesSystemSpacing = Self.usesSystemSpacing
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.moveLhsItemFromRetValLhsItem)
        context._appendOpcode(.moveFirstItemFromRetVal(.rhs))
        context._appendOpcode(.moveFirstAttribute(lhs.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(usesSystemSpacing ? 7 : 6)
        context._appendOpcode(.moveRhsItemFromRetValRhsItem)
        context._appendOpcode(.moveSecondItemFromRetVal(.lhs))
        context._appendOpcode(.moveSecondAttribute(rhs.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveRelation(.equal))
        if usesSystemSpacing {
            context._appendOpcode(.moveUsesSystemSpace(true))
        }
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

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
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        let usesSystemSpacing = Self.usesSystemSpacing
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(2)
        context._appendOpcode(.moveFirstItemFromRetVal(.second))
        context._appendOpcode(.moveFirstAttribute(lhs.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(usesSystemSpacing ? 6 : 5)
        context._appendOpcode(.moveSecondItemFromRetVal(.first))
        context._appendOpcode(.moveSecondAttribute(rhs.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveRelation(.equal))
        if usesSystemSpacing {
            context._appendOpcode(.moveUsesSystemSpace(true))
        }
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

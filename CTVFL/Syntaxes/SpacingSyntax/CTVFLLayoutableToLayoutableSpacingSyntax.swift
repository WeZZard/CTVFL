//
//  CTVFLLayoutableToLayoutableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view1 - view2`
///
public struct CTVFLLayoutableToLayoutableSpacingSyntax<Lhs: CTVFLLayoutableOperand, Rhs: CTVFLLayoutableOperand>:
    CTVFLConstraintsPopulatableSyntax, CTVFLLayoutableOperand, _CTVFLBinarySyntax where
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormLayoutable
    public typealias HeadAssociativity = Lhs.HeadAssociativity
    public typealias TailAssociativity = Rhs.TailAssociativity
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(2)
        context._appendOpcode(.push)
        context._appendOpcode(.moveAttribute(lhs.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.moveEvaluationSite(.secondItem))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(6)
        context._appendOpcode(.moveAttribute(rhs.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.moveUsesSystemSpace(true))
        context._appendOpcode(.moveReturnValue(.secondItem))
        context._appendOpcode(.makeConstraint)
        context._appendOpcode(.pop)
    }
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableSpacingSyntax(lhs: lhs, rhs: rhs)
}

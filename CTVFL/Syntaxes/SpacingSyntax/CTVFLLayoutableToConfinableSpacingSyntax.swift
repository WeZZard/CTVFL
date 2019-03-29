//
//  CTVFLLayoutableToConfinableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view - layoutGuide`
///
public struct CTVFLLayoutableToConfinableSpacingSyntax<Lhs: CTVFLLayoutableOperand, Rhs: CTVFLConfinableOperand>:
    CTVFLConstraintsPopulatableSyntax, CTVFLConfinableOperand, _CTVFLBinarySyntax where
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormConfinable
    public typealias HeadAssociativity = Lhs.HeadAssociativity
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsClosed
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withContext context: CTVFLEvaluationContext) {
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

public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLConfinableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<CTVFLLayoutable, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConfinable(rhs))
}

public func - <Lhs, Rhs: CTVFLConfinableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<Lhs, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: lhs, rhs: Rhs._makeConfinable(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConfinableSpacingSyntax(lhs: lhs, rhs: rhs)
}

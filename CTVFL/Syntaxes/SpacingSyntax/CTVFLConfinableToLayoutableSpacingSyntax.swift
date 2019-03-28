//
//  CTVFLConfinableToLayoutableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `layoutGuide - view`
///
public struct CTVFLConfinableToLayoutableSpacingSyntax<Lhs: CTVFLConfinableOperand, Rhs: CTVFLLayoutableOperand>:
    CTVFLEvaluatableSyntax, CTVFLLayoutableOperand, _CTVFLBinarySyntax where
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormLayoutable
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Rhs.TailAssociativity
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(2)
        storage.append(.push)
        storage.append(.moveAttribute(lhs.attributeForBeingEvaluated(at: .lhs, forOrientation: orientation, withOptions: options)))
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(1)
        storage.append(.moveEvaluationSite(.secondItem))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(6)
        storage.append(.moveAttribute(rhs.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveRelation(.equal))
        storage.append(.moveUsesSystemSpace(true))
        storage.append(.moveReturnValue(.secondItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

public func - <Lhs: CTVFLConfinableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToLayoutableSpacingSyntax<CTVFLConfinable, CTVFLLayoutable> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: Lhs._makeConfinable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToLayoutableSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs: CTVFLConfinableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToLayoutableSpacingSyntax<CTVFLConfinable, Rhs> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: Lhs._makeConfinable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConfinableToLayoutableSpacingSyntax<Lhs, Rhs> {
    return CTVFLConfinableToLayoutableSpacingSyntax(lhs: lhs, rhs: rhs)
}

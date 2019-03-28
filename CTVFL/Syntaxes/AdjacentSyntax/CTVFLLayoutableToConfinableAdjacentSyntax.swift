//
//  CTVFLLayoutableToConfinableAdjacentSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view | layoutGuide`
///
public struct CTVFLLayoutableToConfinableAdjacentSyntax<Lhs: CTVFLLayoutableOperand, Rhs: CTVFLConfinableOperand>:
    CTVFLSyntaxEvaluatable, CTVFLConfinableOperand, _CTVFLBinarySyntax where
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
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(2)
        storage.append(.push)
        storage.append(.moveAttribute(lhs.attributeForBeingConstrained(at: .lhs, forOrientation: orientation, withOptions: options)))
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(1)
        storage.append(.moveEvaluationSite(.secondItem))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(6)
        storage.append(.moveAttribute(rhs.attributeForBeingConstrained(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveRelation(.equal))
        storage.append(.moveConstant(CTVFLConstant(rawValue: 0)))
        storage.append(.moveReturnValue(.secondItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLConfinableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<CTVFLLayoutable, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConfinable(rhs))
}

public func | <Lhs, Rhs: CTVFLConfinableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<Lhs, CTVFLConfinable> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: lhs, rhs: Rhs._makeConfinable(rhs))
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConfinableAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConfinableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

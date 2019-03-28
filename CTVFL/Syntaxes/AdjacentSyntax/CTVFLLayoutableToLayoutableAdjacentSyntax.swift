//
//  CTVFLLayoutableToLayoutableAdjacentSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view1 | view2`
///
public struct CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs: CTVFLLayoutableOperand, Rhs: CTVFLLayoutableOperand>:
    CTVFLEvaluatableSyntax, CTVFLLayoutableOperand, _CTVFLBinarySyntax where
    Lhs.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    Rhs.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias OperableForm = Rhs.OperableForm
    public typealias HeadAssociativity = Lhs.HeadAssociativity
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
        storage.append(.moveConstant(CTVFLConstant(rawValue: 0)))
        storage.append(.moveReturnValue(.secondItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

//
//  CTVFLConstantToLayoutableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `n - view`
///
public struct CTVFLConstantToLayoutableSpacingSyntax<Lhs: CTVFLConstantOperand, Rhs: CTVFLLayoutableOperand>:
    CTVFLEvaluatableSyntax, CTVFLLayoutableOperand, _CTVFLBinarySyntax where
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
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(1)
        storage.append(.moveEvaluationSite(.secondItem))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(4)
        storage.append(.moveAttribute(rhs.attributeForBeingEvaluated(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveReturnValue(.secondItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

public func - <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLConstantToLayoutableSpacingSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSpacingSyntax<Lhs, Rhs> {
    return CTVFLConstantToLayoutableSpacingSyntax(lhs: lhs, rhs: rhs)
}

//
//  CTVFLConstantToConfinableSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `n - layoutGuide`
///
public struct CTVFLConstantToConfinableSpacingSyntax<Lhs: CTVFLConstantOperand, Rhs: CTVFLConfinableOperand>:
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
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(1)
        storage.append(.moveEvaluationSite(.secondItem))
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(4)
        storage.append(.moveAttribute(rhs.attributeForBeingConstrained(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveReturnValue(.secondItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

public func - <Lhs, Rhs: CTVFLConfinableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToConfinableSpacingSyntax<Lhs, CTVFLConfinable> {
    return CTVFLConstantToConfinableSpacingSyntax(lhs: lhs, rhs: Rhs._makeConfinable(rhs))
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToConfinableSpacingSyntax<Lhs, Rhs> {
    return CTVFLConstantToConfinableSpacingSyntax(lhs: lhs, rhs: rhs)
}

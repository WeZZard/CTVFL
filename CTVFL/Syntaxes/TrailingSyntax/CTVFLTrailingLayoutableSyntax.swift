//
//  CTVFLTrailingLayoutableSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view|`
///
public struct CTVFLTrailingLayoutableSyntax<O: CTVFLLayoutableOperand>:
    CTVFLSyntaxEvaluatable, CTVFLLayoutableOperand, _CTVFLTrailingSyntax where
    O.TailAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = Operand.OperableForm
    public typealias HeadAssociativity = Operand.HeadAssociativity
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsClosed
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(3)
        storage.append(.push)
        storage.append(.moveConstant(CTVFLConstant(rawValue: 0)))
        storage.append(.moveRelation(.equal))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(6)
        storage.append(.moveAttribute(operand.attributeForBeingConstrained(at: .lhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveReturnValue(.firstItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

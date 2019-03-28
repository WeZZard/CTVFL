//
//  CTVFLTrailingLayoutableWithSystemSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `view-|`
///
public struct CTVFLTrailingLayoutableWithSystemSpacingSyntax<O: CTVFLLayoutableOperand>:
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
        storage._ensureTailElements(4)
        storage.append(.push)
        storage.append(.moveUsesSystemSpace(true))
        storage.append(.moveRelation(.equal))
        storage.append(.moveAttribute(operand.attributeForBeingConstrained(at: .lhs, forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(5)
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveReturnValue(.firstItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

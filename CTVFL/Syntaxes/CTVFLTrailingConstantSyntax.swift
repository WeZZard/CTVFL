//
//  CTVFLTrailingConstantSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `n-|`
///
public struct CTVFLTrailingConstantSyntax<O: CTVFLConstantOperand>:
    CTVFLOperand, CTVFLConstantOperand, _CTVFLTrailingSyntax where
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
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(5)
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveReturnValue(.firstItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

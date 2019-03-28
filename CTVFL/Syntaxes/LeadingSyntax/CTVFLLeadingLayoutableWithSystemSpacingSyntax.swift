//
//  CTVFLLeadingLayoutableWithSpacingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `|-view`
///
public struct CTVFLLeadingLayoutableWithSpacingSyntax<O: CTVFLLayoutableOperand>:
    CTVFLSyntaxEvaluatable, CTVFLLayoutableOperand, _CTVFLLeadingSyntax where
    O.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias OperableForm = Operand.OperableForm
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Operand.TailAssociativity
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(7)
        storage.append(.push)
        storage.append(.moveUsesSystemSpace(true))
        storage.append(.moveRelation(.equal))
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(attributeForContainer(at: .lhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveAttribute(operand.attributeForBeingConstrained(at: .rhs, forOrientation: orientation, withOptions: options)))
        storage.append(.moveEvaluationSite(.secondItem))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(3)
        storage.append(.moveReturnValue(.secondItem))
        storage.append(.makeConstraint)
        storage.append(.pop)
    }
}

public prefix func |- <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLLeadingLayoutableWithSpacingSyntax<CTVFLLayoutable> {
    return CTVFLLeadingLayoutableWithSpacingSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func |- <Operand>(operand: Operand) -> CTVFLLeadingLayoutableWithSpacingSyntax<Operand> {
    return CTVFLLeadingLayoutableWithSpacingSyntax(operand: operand)
}

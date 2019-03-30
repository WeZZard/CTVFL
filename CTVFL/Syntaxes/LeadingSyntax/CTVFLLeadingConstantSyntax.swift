//
//  CTVFLLeadingConstantSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `|-n`, `|-(>=n)`, `|-(>=n ~ m)`
///
public struct CTVFLLeadingConstantSyntax<O: CTVFLAssociableOperand>:
    CTVFLEdgeSpaceOperand, CTVFLUnarySyntax where
    O.HeadAttribute == CTVFLSyntaxAttributeConstant,
    O.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
    public typealias TailBoundary = Operand.TailBoundary
    public typealias HeadAttribute = CTVFLSyntaxAttributeConfinment
    public typealias TailAttribute = CTVFLSyntaxAttributeConstant
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Operand.TailAssociativity
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(3)
        context._appendOpcode(.push)
        context._appendOpcode(.moveFirstItem(.container))
        context._appendOpcode(.moveFirstAttribute(attributeForContainer(at: .lhs, forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(4)
        context._appendOpcode(.moveConstantFromRetVal)
        context._appendOpcode(.moveReleationFromRetVal)
        context._appendOpcode(.movePriorityFromRetVal)
        context._appendOpcode(.pop)
    }
}

public prefix func |- <Operand: CTVFLExpressibleByConstantLiteral>(operand: Operand) -> CTVFLLeadingConstantSyntax<CTVFLConstant> {
    return CTVFLLeadingConstantSyntax(operand: Operand._makeConstant(operand))
}

public prefix func |- <Operand>(operand: Operand) -> CTVFLLeadingConstantSyntax<Operand> {
    return CTVFLLeadingConstantSyntax(operand: operand)
}

//
//  CTVFLTrailingConstantSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


/// `n-|`, `(>=n)-|`, `(>=n ~ m)-|`
///
public struct CTVFLTrailingConstantSyntax<O: CTVFLAssociableOperand>:
    CTVFLEdgeSpaceOperand, CTVFLUnarySyntax where
    O.TailAttribute == CTVFLSyntaxAttributeConstant,
    O.TailAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    public typealias Operand = O
    
    public typealias HeadBoundary = Operand.HeadBoundary
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
    public typealias HeadAttribute = CTVFLSyntaxAttributeConstant
    public typealias TailAttribute = CTVFLSyntaxAttributeConfinement
    public typealias HeadAssociativity = Operand.HeadAssociativity
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsClosed
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withContext: context)
        context._ensureOpcodesTailElements(8)
        context._appendOpcode(.moveConstantFromRetVal)
        context._appendOpcode(.moveReleationFromRetVal)
        context._appendOpcode(.movePriorityFromRetVal)
        context._appendOpcode(.moveLhsItem(.container))
        context._appendOpcode(.moveRhsItem(.container))
        context._appendOpcode(.moveSecondAttribute(attributeForContainer(at: .rhs, forOrientation: orientation, withOptions: options)))
        context._appendOpcode(.pop)
    }
}

public postfix func -| <Operand: CTVFLExpressibleByConstantLiteral>(operand: Operand) -> CTVFLTrailingConstantSyntax<CTVFLConstant> {
    return CTVFLTrailingConstantSyntax(operand: Operand._makeConstant(operand))
}

public postfix func -| <Operand>(operand: Operand) -> CTVFLTrailingConstantSyntax<Operand> {
    return CTVFLTrailingConstantSyntax(operand: operand)
}

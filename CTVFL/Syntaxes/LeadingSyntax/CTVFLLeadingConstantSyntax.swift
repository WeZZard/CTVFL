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
    
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
    public typealias TailBoundary = Operand.TailBoundary
    public typealias HeadAttribute = CTVFLSyntaxAttributeConfinement
    public typealias TailAttribute = CTVFLSyntaxAttributeConstant
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsClosed
    public typealias TailAssociativity = Operand.TailAssociativity
    
    public let operand: Operand
    
    @inline(__always)
    public init(operand: Operand) {
        self.operand = operand
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(5)
        context._appendOpcode(.push)
        context._appendOpcode(.moveLhsItem(.container))
        context._appendOpcode(.moveRhsItem(.container))
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

@inlinable
public prefix func |- <Operand: CTVFLExpressibleByConstantLiteral>(operand: Operand) -> CTVFLLeadingConstantSyntax<CTVFLConstant> {
    return CTVFLLeadingConstantSyntax(operand: Operand._makeConstant(operand))
}

@inlinable
public prefix func |- <Operand>(operand: Operand) -> CTVFLLeadingConstantSyntax<Operand> {
    return CTVFLLeadingConstantSyntax(operand: operand)
}

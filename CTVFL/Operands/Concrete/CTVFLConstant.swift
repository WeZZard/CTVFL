//
//  CTVFLConstant.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import CoreGraphics

public struct CTVFLConstant: CTVFLAssociableOperand,
    RawRepresentable,
    Equatable,
    CustomStringConvertible
{
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsConstant
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsConstant
    public typealias HeadAttribute = CTVFLSyntaxAttributeConstant
    public typealias TailAttribute = CTVFLSyntaxAttributeConstant
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    public typealias RawValue = Float
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public var description: String {
        return rawValue.description
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(4)
        context._appendOpcode(.push)
        context._appendOpcode(.moveConstant(CGFloat(rawValue)))
        context._appendOpcode(.moveRelation(.equal))
        context._appendOpcode(.pop)
    }
}

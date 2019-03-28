//
//  CTVFLConstant.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import CoreGraphics

public struct CTVFLConstant: Equatable, RawRepresentable,
    CustomStringConvertible,
    CTVFLConstantOperand
{
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormConstant
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
    
    public func generateOpcodes(forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(3)
        storage.append(.moveConstant(self))
        storage.append(.moveRelation(.equal))
        storage.append(.movePriority(.required))
    }
}

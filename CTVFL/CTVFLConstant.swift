//
//  CTVFLConstant.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import CoreGraphics

public struct CTVFLConstant: RawRepresentable, CustomStringConvertible,
    CTVFLOperand
{
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithConstant
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public typealias RawValue = Double
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public var description: String {
        return rawValue.description
    }
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        return [.pushConstant(CGFloat(rawValue))]
    }
}

// MARK: - CTVFLConstantConvertible
public protocol CTVFLConstantConvertible {
    static func _makeConstant(_ value: Self) -> CTVFLConstant
}

extension Int: CTVFLConstantConvertible {
    @inline(__always)
    public static func _makeConstant(_ value: Int) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

extension Float: CTVFLConstantConvertible {
    @inline(__always)
    public static func _makeConstant(_ value: Float) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

extension Double: CTVFLConstantConvertible {
    @inline(__always)
    public static func _makeConstant(_ value: Double) -> CTVFLConstant {
        return .init(rawValue: value)
    }
}

extension CGFloat: CTVFLConstantConvertible {
    @inline(__always)
    public static func _makeConstant(_ value: CGFloat) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

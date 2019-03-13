//
//  CTVFLConstant.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import CoreGraphics

public struct CTVFLConstant: RawRepresentable, CustomStringConvertible {
    public typealias RawValue = Double
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public var description: String {
        return rawValue.description
    }
}

// MARK: - CTVFLConstantConvertible
public protocol CTVFLConstantConvertible {
    static func _makeConstant(_ value: Self) -> CTVFLConstant
}

extension Int: CTVFLConstantConvertible {
    public static func _makeConstant(_ value: Int) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

extension Float: CTVFLConstantConvertible {
    public static func _makeConstant(_ value: Float) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

extension Double: CTVFLConstantConvertible {
    public static func _makeConstant(_ value: Double) -> CTVFLConstant {
        return .init(rawValue: value)
    }
}

extension CGFloat: CTVFLConstantConvertible {
    public static func _makeConstant(_ value: CGFloat) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

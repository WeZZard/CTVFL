//
//  CTVFLConstantConvertible.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


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
        return .init(rawValue: value)
    }
}

extension Double: CTVFLConstantConvertible {
    @inline(__always)
    public static func _makeConstant(_ value: Double) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

extension CGFloat: CTVFLConstantConvertible {
    @inline(__always)
    public static func _makeConstant(_ value: CGFloat) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

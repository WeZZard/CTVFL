//
//  CTVFLExpressibleByConstantLiteral.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol CTVFLExpressibleByConstantLiteral {
    static func _makeConstant(_ value: Self) -> CTVFLConstant
}

extension BinaryFloatingPoint where Self: CTVFLExpressibleByConstantLiteral {
    @inline(__always)
    public static func _makeConstant(_ value: Self) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

extension BinaryInteger where Self: CTVFLExpressibleByConstantLiteral {
    @inline(__always)
    public static func _makeConstant(_ value: Self) -> CTVFLConstant {
        return .init(rawValue: .init(value))
    }
}

extension Int: CTVFLExpressibleByConstantLiteral { }

extension Float: CTVFLExpressibleByConstantLiteral { }

extension Double: CTVFLExpressibleByConstantLiteral { }

extension CGFloat: CTVFLExpressibleByConstantLiteral { }

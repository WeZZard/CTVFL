//
//  CTVFLConfinableConvertible.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLConfinableConvertible {
    static func _makeConfinable(_ value: Self) -> CTVFLConfinable
}

extension CTVFLLayoutGuide: CTVFLConfinableConvertible {
    @inline(__always)
    public static func _makeConfinable(_ value: CTVFLLayoutGuide) -> CTVFLConfinable {
        return .init(value)
    }
}

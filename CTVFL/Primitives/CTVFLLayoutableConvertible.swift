//
//  CTVFLLayoutableConvertible.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLLayoutableConvertible {
    static func _makeLayoutable(_ value: Self) -> CTVFLLayoutable
}

extension CTVFLView: CTVFLLayoutableConvertible {
    @inline(__always)
    public static func _makeLayoutable(_ value: CTVFLView) -> CTVFLLayoutable {
        return .init(rawValue: value)
    }
}

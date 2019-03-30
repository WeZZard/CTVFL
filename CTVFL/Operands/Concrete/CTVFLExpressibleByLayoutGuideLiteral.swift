//
//  CTVFLExpressibleByLayoutGuideLiteral.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLExpressibleByLayoutGuideLiteral {
    static func _makeConfinable(_ value: Self) -> CTVFLConfinable
}

extension CTVFLLayoutGuide: CTVFLExpressibleByLayoutGuideLiteral {
    @inline(__always)
    public static func _makeConfinable(_ value: CTVFLLayoutGuide) -> CTVFLConfinable {
        return .init(value)
    }
}

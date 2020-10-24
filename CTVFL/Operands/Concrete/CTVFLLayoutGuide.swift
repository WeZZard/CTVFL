//
//  CTVFLExpressibleByLayoutGuideLiteral.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

extension CTVFLLayoutGuide {
    @inline(__always)
    public static func _makeConfinable(_ value: CTVFLLayoutGuide) -> CTVFLConfinable {
        return .init(value)
    }
}

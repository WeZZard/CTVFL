//
//  CTVFLExpressibleByViewLiteral.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLExpressibleByViewLiteral {
    static func _makeLayoutable(_ value: Self) -> CTVFLLayoutable
}

extension CTVFLView: CTVFLExpressibleByViewLiteral {
    @inline(__always)
    public static func _makeLayoutable(_ value: CTVFLView) -> CTVFLLayoutable {
        return .init(value)
    }
}

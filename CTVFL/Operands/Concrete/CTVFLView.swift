//
//  CTVFLExpressibleByViewLiteral.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

extension CTVFLView {
    @inline(__always)
    public static func _makeLayoutable(_ value: CTVFLView) -> CTVFLLayoutable {
        return .init(value)
    }
}

//
//  CTVFLAnySyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLAnySyntax {
    func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>)
}

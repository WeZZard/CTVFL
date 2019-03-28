//
//  CTVFLOpcodeGenerating.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLOpcodeGenerating {
    func generateOpcodes(forOrientation orientation: CTVFLLayoutAnchorSelectableOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>)
}

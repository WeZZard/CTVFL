//
//  CTVFLObjectBasedOperand.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLObjectBasedOperand: CTVFLOperand {
    func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute
}

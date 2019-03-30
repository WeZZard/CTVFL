//
//  CTVFLAssociatedOperand.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

/// An operand have already been associated.
///
public protocol CTVFLAssociatedOperand: CTVFLOperand {
    func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute
}

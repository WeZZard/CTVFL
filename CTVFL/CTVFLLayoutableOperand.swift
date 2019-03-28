//
//  CTVFLLayoutableOperand.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLLayoutableOperand: CTVFLOperand where
    OperableForm == CTVFLSyntaxOperableFormLayoutable
{
    func attributeForBeingConstrained(at side: CTVFLNSLayoutConstrainedSide, forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: NSLayoutFormatOptions) -> NSLayoutAttribute
}

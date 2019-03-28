//
//  CTVFLConfinableOperand.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLConfinableOperand: CTVFLOperand where
    OperableForm == CTVFLSyntaxOperableFormConfinable
{
    func attributeForBeingConstrained(at side: CTVFLLayoutAnchorSelectableSide, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute
}

//
//  _CTVFLBinarySyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol _CTVFLBinarySyntax: CTVFLOperand where
    LhsOperand.TailAssociativity == CTVFLSyntaxAssociativityIsOpen,
    RhsOperand.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    associatedtype LhsOperand: CTVFLOperand
    associatedtype RhsOperand: CTVFLOperand
    
    var lhs: LhsOperand { get }
    var rhs: RhsOperand { get }
}

extension _CTVFLBinarySyntax where Self: CTVFLObjectBasedOperand, RhsOperand: CTVFLObjectBasedOperand {
    public func attributeForBeingConstrained(at side: CTVFLLayoutAnchorSelectableSide, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute {
        return rhs.attributeForBeingConstrained(at: side, forOrientation: orientation, withOptions: options)
    }
}

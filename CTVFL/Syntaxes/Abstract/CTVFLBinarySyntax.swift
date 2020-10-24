//
//  CTVFLBinarySyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public protocol CTVFLBinarySyntax: CTVFLOperand {
    associatedtype LhsOperand: CTVFLOperand
    associatedtype RhsOperand: CTVFLOperand
    
    associatedtype HeadBoundary = LhsOperand.HeadBoundary
    associatedtype TailBoundary = RhsOperand.TailBoundary
    associatedtype HeadAttribute = LhsOperand.HeadAttribute
    associatedtype TailAttribute = RhsOperand.TailAttribute
    associatedtype HeadAssociativity = LhsOperand.HeadAssociativity
    associatedtype TailAssociativity = RhsOperand.TailAssociativity
    
    var lhs: LhsOperand { get }
    var rhs: RhsOperand { get }
}

extension CTVFLBinarySyntax where Self: CTVFLAssociatedOperand, RhsOperand: CTVFLAssociatedOperand {
    @inlinable
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        return rhs.attributeForBeingEvaluated(at: site, forOrientation: orientation, withOptions: options)
    }
}

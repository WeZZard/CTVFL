//
//  CTVFLConstraintsPopulatableSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol CTVFLConstraintsPopulatableSyntax: CTVFLAnySyntax {
    func makeConstraints(orientation: CTVFLOrientation, options: CTVFLOptions) -> [CTVFLConstraint]
}

extension CTVFLConstraintsPopulatableSyntax {
    public func makeConstraints(orientation: CTVFLOrientation, options: CTVFLOptions) -> [CTVFLConstraint] {
        let evaluationContext = CTVFLTransaction.sharedEvaluationContext
        
        let constraints = evaluationContext.makeConstraint(withSyntax: self, forOrientation: orientation, withOptions: options);
        
        return constraints;
    }
}

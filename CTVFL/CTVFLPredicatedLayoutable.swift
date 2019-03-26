//
//  CTVFLPredicatedLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public class CTVFLPredicatedLayoutable: CTVFLPopulatableOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithLayoutable
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    internal let _layoutable: CTVFLLayoutable
    
    internal let _predicates: [CTVFLPredicate]
    
    internal init(
        layoutable: CTVFLLayoutable,
        predicates: [CTVFLPredicating]
        )
    {
        _layoutable = layoutable
        _predicates = predicates.map({$0._toCTVFLPredicate()})
    }
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        return _predicates.map({ (predicate) -> [[CTVFLOpCode]] in [
            [.pushItem(.view(_layoutable._item))],
            predicate.opCodes(forOrientation: orientation, withOptions: options),
            [.makeConstraint]
        ]}).flatMap({$0.flatMap{$0}})
    }
}

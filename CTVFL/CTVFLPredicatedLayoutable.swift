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
    
    internal let _predicates: [CTVFLPredicating]
    
    internal init(
        layoutable: CTVFLLayoutable,
        predicates: [CTVFLPredicating]
        )
    {
        _layoutable = layoutable
        _predicates = predicates.map({$0})
    }
    
    public func opcodes(
        forOrientation orientation: CTVFLConstraintOrientation,
        withOptions options: CTVFLOptions
        ) -> [CTVFLOpcode]
    {
        return _predicates.map({ (predicate) -> [[CTVFLOpcode]] in [
            [
                .push,
                .moveItem(.layoutable(_layoutable)),
            ],
            predicate.opcodes(forOrientation: orientation, forObject: .dimension, withOptions: options),
            [
                .pop
            ],
        ]}).flatMap({$0.flatMap{$0}}) + [.loadLhsItem]
    }
}

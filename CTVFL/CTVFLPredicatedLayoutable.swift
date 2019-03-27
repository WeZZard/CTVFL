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
    
    public func generateOpcodes(
        forOrientation orientation: CTVFLConstraintOrientation,
        withOptions options: CTVFLOptions,
        withStorage storage: inout ContiguousArray<CTVFLOpcode>
        )
    {
        storage._ensureTailElements(3 * _predicates.count + 1)
        for eachPredicate in _predicates {
            storage.append(.push)
            storage.append(.moveItem(.layoutable(_layoutable)))
            eachPredicate.generateOpcodes(forOrientation: orientation, forObject: .dimension, withOptions: options, withStorage: &storage)
            storage.append(.pop)
        }
        storage.append(.loadLhsItem)
    }
}

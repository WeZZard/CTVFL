//
//  CTVFLPredicatedLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public class CTVFLPredicatedLayoutable: CTVFLSyntaxEvaluatable,
    CTVFLLayoutableOperand
{
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormLayoutable
    // TODO: Extract from layoutable
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
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
        forOrientation orientation: CTVFLNSLayoutConstrainedOrientation,
        withOptions options: CTVFLOptions,
        withStorage storage: inout ContiguousArray<CTVFLOpcode>
        )
    {
        for eachPredicate in _predicates {
            storage._ensureTailElements(2)
            storage.append(.push)
            storage.append(.moveItem(.layoutable(_layoutable)))
            eachPredicate.generateOpcodes(forOrientation: orientation, forObject: .dimension, withOptions: options, withStorage: &storage)
            storage._ensureTailElements(1)
            storage.append(.pop)
        }
        storage.append(.loadLhsItem)
    }
    
    public func attributeForBeingConstrained(at side: CTVFLNSLayoutConstrainedSide, forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: NSLayoutFormatOptions) -> NSLayoutAttribute {
        return _layoutable.attributeForBeingConstrained(at: side, forOrientation: orientation, withOptions: options)
    }
}

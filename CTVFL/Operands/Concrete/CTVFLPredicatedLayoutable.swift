//
//  CTVFLPredicatedLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public class CTVFLPredicatedLayoutable: CTVFLConstraintsPopulatableSyntax,
    CTVFLLayoutableOperand
{
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormLayoutable
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
        forOrientation orientation: CTVFLOrientation,
        withOptions options: CTVFLFormatOptions,
        withContext context: CTVFLEvaluationContext
        )
    {
        for eachPredicate in _predicates {
            context._ensureOpcodesTailElements(2)
            context._appendOpcode(.push)
            context._appendOpcode(.moveItem(.layoutable(_layoutable)))
            eachPredicate.generateOpcodes(forOrientation: orientation, forObject: .dimension, withOptions: options, withContext: context)
            context._ensureOpcodesTailElements(3)
            context._appendOpcode(.moveReturnValue(.firstItem))
            context._appendOpcode(.makeConstraint)
            context._appendOpcode(.pop)
        }
    }
    
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        return _layoutable.attributeForBeingEvaluated(at: site, forOrientation: orientation, withOptions: options)
    }
}

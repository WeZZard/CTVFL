//
//  CTVFLPredicatedLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public class CTVFLPredicatedLayoutable: CTVFLAssociatedOperand,
    CTVFLConstraintsPopulatableSyntax
{
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
    public typealias HeadAttribute = CTVFLSyntaxAttributeLayoutedObject
    public typealias TailAttribute = CTVFLSyntaxAttributeLayoutedObject
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
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.push)
        for eachPredicate in _predicates {
            context._ensureOpcodesTailElements(2)
            context._appendOpcode(.push)
            context._appendOpcode(.moveFirstItem(.layoutable(_layoutable)))
            switch eachPredicate.toCTVFLGenericPredicate() {
            case let .constant(constantPredicate):
                constantPredicate.generateOpcodes(forOrientation: orientation, forObject: .dimension, withOptions: options, withContext: context)
                context._ensureOpcodesTailElements(4)
                context._appendOpcode(.moveFirstAttributeFromRetVal(.first))
                context._appendOpcode(.moveReleationFromRetVal)
                context._appendOpcode(.moveConstantFromRetVal)
                context._appendOpcode(.movePriorityFromRetVal)
            case let .layoutable(layoutablePredicate):
                layoutablePredicate.generateOpcodes(forOrientation: orientation, forObject: .dimension, withOptions: options, withContext: context)
                context._ensureOpcodesTailElements(5)
                context._appendOpcode(.moveFirstAttributeFromRetVal(.first))
                context._appendOpcode(.moveSecondItemFromRetVal(.second))
                context._appendOpcode(.moveSecondAttributeFromRetVal(.second))
                context._appendOpcode(.moveReleationFromRetVal)
                context._appendOpcode(.movePriorityFromRetVal)
            }
            context._ensureOpcodesTailElements(2)
            context._appendOpcode(.makeConstraint)
            context._appendOpcode(.pop)
        }
        context._ensureOpcodesTailElements(2)
        context._appendOpcode(.moveLhsItem(.layoutable(_layoutable)))
        context._appendOpcode(.moveRhsItem(.layoutable(_layoutable)))
        context._appendOpcode(.pop)
    }
    
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        return _layoutable.attributeForBeingEvaluated(at: site, forOrientation: orientation, withOptions: options)
    }
}

//
//  CTVFLPredicatedLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public class CTVFLPredicatedLayoutable: CTVFLAssociatedOperand,
    CTVFLConstraintsPopulatableSyntax
{
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinement
    public typealias HeadAttribute = CTVFLSyntaxAttributeLayoutedObject
    public typealias TailAttribute = CTVFLSyntaxAttributeLayoutedObject
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    @usableFromInline
    internal let _layoutable: CTVFLLayoutable
    
    @usableFromInline
    internal let _predicates: [CTVFLPredicating]
    
    @inline(__always)
    internal init(
        layoutable: CTVFLLayoutable,
        predicates: [CTVFLPredicating]
        )
    {
        _layoutable = layoutable
        _predicates = predicates.map({$0})
    }
    
    @inlinable
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
    
    @inlinable
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        return _layoutable.attributeForBeingEvaluated(at: site, forOrientation: orientation, withOptions: options)
    }
}

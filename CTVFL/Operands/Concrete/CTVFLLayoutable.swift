//
//  CTVFLLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

/// An instance of `CTVFLLayoutable` does not hold a strong reference to
/// its internal view.
///
public struct CTVFLLayoutable: Hashable, CTVFLAssociatedOperand {
    public typealias HeadBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
    public typealias TailBoundary = CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment
    public typealias HeadAttribute = CTVFLSyntaxAttributeLayoutedObject
    public typealias TailAttribute = CTVFLSyntaxAttributeLayoutedObject
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    internal unowned(unsafe) var _view: CTVFLLayoutAnchorSelectable
    
    internal init(_ view: CTVFLView) {
        _view = view
    }
    
    internal var _asAnchorSelector: CTVFLLayoutAnchorSelectable {
        return _view
    }
    
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(_view).hash(into: &hasher)
    }
    
    public static func == (lhs: CTVFLLayoutable, rhs: CTVFLLayoutable) -> Bool {
        return lhs._view === rhs._view
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(5)
        context._appendOpcode(.push)
        context._appendOpcode(.moveLhsItem(.layoutable(self)))
        context._appendOpcode(.moveRhsItem(.layoutable(self)))
        context._appendOpcode(.pop)
    }
    
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        return _view._ctvfl_attributeForBeingEvaluated(at: site, for: orientation, with: options)
    }
}

//
//  CTVFLLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

/// An instance of `CTVFLLayoutable` does not hold a strong reference to
/// its internal view.
///
public struct CTVFLLayoutable: Hashable, CTVFLLayoutableOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormLayoutable
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    internal unowned(unsafe) var _view: CTVFLLayoutAnchorSelectable
    
    internal init(_ view: CTVFLView) {
        _view = view
    }
    
    internal var _asAnchorSelector: CTVFLLayoutAnchorSelectable {
        return _view
    }
    
    // MARK: Hashable
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(_view).hash(into: &hasher)
    }
    
    public static func == (lhs: CTVFLLayoutable, rhs: CTVFLLayoutable) -> Bool {
        return lhs._view === rhs._view
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.moveItem(.layoutable(self)))
    }
    
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        return _view._ctvfl_attributeForBeingEvaluated(at: site, for: orientation, with: options)
    }
}

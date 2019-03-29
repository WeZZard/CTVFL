//
//  CTVFLConfinable.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

/// An instance of `CTVFLConfinable` does not hold a strong reference to
/// its internal layout guide.
///
public struct CTVFLConfinable: Hashable, CTVFLConfinableOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormConfinable
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    internal unowned(unsafe) var _layoutGuide: CTVFLLayoutAnchorSelectable
    
    internal init(_ layoutGuide: CTVFLLayoutGuide) {
        _layoutGuide = layoutGuide
    }
    
    internal var _asAnchorSelector: CTVFLLayoutAnchorSelectable { return _layoutGuide }
    
    // MARK: Hashable
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(_layoutGuide).hash(into: &hasher)
    }
    
    public static func == (lhs: CTVFLConfinable, rhs: CTVFLConfinable) -> Bool {
        return lhs._layoutGuide === rhs._layoutGuide
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withContext context: CTVFLEvaluationContext) {
        context._ensureOpcodesTailElements(1)
        context._appendOpcode(.moveItem(.confinable(self)))
    }
    
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute {
        return _layoutGuide._ctvfl_attributeForBeingEvaluated(at: site, for: orientation, with: options)
    }
}

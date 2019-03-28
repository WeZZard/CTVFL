//
//  CTVFLConfinable.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public struct CTVFLConfinable: RawRepresentable, Hashable, CTVFLConfinableOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormConfinable
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    public typealias RawValue = CTVFLLayoutAnchorSelectable
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ view: CTVFLView) {
        rawValue = view
    }
    
    internal var _asAnchorSelector: CTVFLLayoutAnchorSelectable { return rawValue }
    
    // MARK: Hashable
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(rawValue).hash(into: &hasher)
    }
    
    public static func == (lhs: CTVFLConfinable, rhs: CTVFLConfinable) -> Bool {
        return lhs.rawValue === rhs.rawValue
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(1)
        storage.append(.moveItem(.confinable(self)))
    }
    
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute {
        return rawValue._ctvfl_attributeForBeingEvaluated(at: site, for: orientation, with: options)
    }
}

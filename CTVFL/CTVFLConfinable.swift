//
//  CTVFLConfinable.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public struct CTVFLConfinable: RawRepresentable, Hashable, CTVFLLayoutableOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormLayoutable
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
    public var hashValue: Int {
        return ObjectIdentifier(rawValue).hashValue
    }
    
    public static func == (lhs: CTVFLConfinable, rhs: CTVFLConfinable) -> Bool {
        return lhs.rawValue === rhs.rawValue
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLLayoutAnchorSelectableOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(1)
        storage.append(.moveItem(.confinable(self)))
    }
    
    public func attributeForBeingConstrained(at side: CTVFLLayoutAnchorSelectableSide, forOrientation orientation: CTVFLLayoutAnchorSelectableOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute {
        return rawValue._ctvfl_attributeForBeingConstrained(at: side, for: orientation, with: options)
    }
}

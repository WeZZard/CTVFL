//
//  CTVFLLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public struct CTVFLLayoutable: RawRepresentable, Hashable, CTVFLLayoutableOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias OperableForm = CTVFLSyntaxOperableFormLayoutable
    // TODO: Extract from RawValue
    public typealias HeadAssociativity = CTVFLSyntaxAssociativityIsOpen
    public typealias TailAssociativity = CTVFLSyntaxAssociativityIsOpen
    
    public typealias RawValue = CTVFLNSLayoutConstrained
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ view: CTVFLView) {
        rawValue = view
    }
    
    internal var _item: CTVFLNSLayoutConstrained { return rawValue }
    
    // MARK: Hashable
    public var hashValue: Int {
        return ObjectIdentifier(rawValue).hashValue
    }
    
    public static func == (lhs: CTVFLLayoutable, rhs: CTVFLLayoutable) -> Bool {
        return lhs.rawValue === rhs.rawValue
    }
    
    public func generateOpcodes(forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(1)
        storage.append(.moveItem(.layoutable(self)))
    }
    
    public func attributeForBeingConstrained(at side: CTVFLNSLayoutConstrainedSide, forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: NSLayoutFormatOptions) -> NSLayoutAttribute {
        return rawValue._ctvfl_attributeForBeingConstrained(at: side, for: orientation, with: options)
    }
}

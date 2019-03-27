//
//  CTVFLLayoutable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public struct CTVFLLayoutable: RawRepresentable, Hashable, CTVFLOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithLayoutable
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public typealias RawValue = AnyObject
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ view: AnyObject) {
        rawValue = view
    }
    
    internal var _item: AnyObject { return rawValue }
    
    // MARK: Hashable
    public var hashValue: Int {
        return ObjectIdentifier(rawValue).hashValue
    }
    
    public static func == (lhs: CTVFLLayoutable, rhs: CTVFLLayoutable) -> Bool {
        return lhs.rawValue === rhs.rawValue
    }
    
    public func opcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpcode] {
        return [.moveItem(.layoutable(self))]
    }
}

// MARK: - CTVFLLayoutableConvertible
public protocol CTVFLLayoutableConvertible {
    static func _makeLayoutable(_ value: Self) -> CTVFLLayoutable
}

extension CTVFLView: CTVFLLayoutableConvertible {
    @inline(__always)
    public static func _makeLayoutable(_ value: CTVFLView) -> CTVFLLayoutable {
        return .init(rawValue: value)
    }
}

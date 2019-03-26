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
    
    public typealias RawValue = View
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ view: View) {
        rawValue = view
    }
    
    internal var _item: View { return rawValue }
    
    // MARK: Hashable
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public static func == (lhs: CTVFLLayoutable, rhs: CTVFLLayoutable) -> Bool {
        return lhs.rawValue === rhs.rawValue
    }
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        return [.pushItem(.view(_item))]
    }
}

// MARK: - CTVFLLayoutableConvertible
public protocol CTVFLLayoutableConvertible {
    static func _makeLayoutable(_ value: Self) -> CTVFLLayoutable
}

extension View: CTVFLLayoutableConvertible {
    @inline(__always)
    public static func _makeLayoutable(_ value: View) -> CTVFLLayoutable {
        return .init(rawValue: value)
    }
}

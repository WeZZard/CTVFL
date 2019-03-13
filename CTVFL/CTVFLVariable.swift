//
//  CTVFLVariable.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

public struct CTVFLVariable: RawRepresentable, Hashable {
    public typealias RawValue = View
    
    public var rawValue: RawValue
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    internal init(_ view: View) {
        rawValue = view
    }
    
    internal var _view: View { return rawValue }
    
    // MARK: Hashable
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public static func == (lhs: CTVFLVariable, rhs: CTVFLVariable) -> Bool {
        return lhs.rawValue === rhs.rawValue
    }
}

// MARK: - CTVFLVariableConvertible
public protocol CTVFLVariableConvertible {
    static func _makeVariable(_ value: Self) -> CTVFLVariable
}

extension View: CTVFLVariableConvertible {
    public static func _makeVariable(_ value: View) -> CTVFLVariable {
        return .init(value)
    }
}

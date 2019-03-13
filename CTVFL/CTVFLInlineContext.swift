//
//  CTVFLInlineContext.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import Foundation

public class CTVFLInlineContext {
    // MARK: Accessing Managed Views
    internal var _views: [String: View] {
        var variables = [String: CTVFLVariable]()
        
        for (variable, name) in _nameForVariable {
            variables[name] = variable
        }
        
        if let overridingVariables =
            CTVFLGlobalContext.shared?.overridingVariables
        {
            for (name, variable) in overridingVariables {
                variables[name] = variable
            }
        }
        
        return variables.mapValues({$0._view})
    }
    
    // MARK: Managing Variable Names
    internal func _name(forVariable variable: CTVFLVariable) -> String {
        if let overridingName =
            CTVFLGlobalContext.shared?.overridingName(for: variable)
        {
            return overridingName
        } else if let existedName = _nameForVariable[variable] {
            return existedName
        } else {
            let name = _makeNonDuplicateRandomName(for: 8)
            _nameForVariable[variable] = name
            return name
        }
    }
    
    internal func _makeNonDuplicateRandomName(for length: Int) -> String {
        let existedNames = _existedNames
        
        var aRandomName = _makeRandomName(for: length)
        
        while existedNames.contains(aRandomName) {
            aRandomName = _makeRandomName(for: length)
        }
        
        return aRandomName
    }
    
    internal func _makeRandomName(for length: Int) -> String {
        let initialPivotOffset = Int(arc4random_uniform(UInt32(alphabet.count)))
        let initialPivot = alphabet.index(alphabet.startIndex, offsetBy: initialPivotOffset)
        let initialLetter = alphabet[initialPivot]
        
        var randomName = String()
        
        randomName.append(initialLetter)
        
        for _ in 0..<(length - 1) {
            let pivotOffset = Int(arc4random_uniform(UInt32(alphanumeric.count)))
            let pivot = alphanumeric.index(alphanumeric.startIndex, offsetBy: pivotOffset)
            let letter = alphanumeric[pivot]
            randomName.append(letter)
        }
        
        return randomName
    }
    
    internal var _existedNames: Set<String> {
        let existedInlineNames = Set(_nameForVariable.values)
        
        if let overridingVariables =
            CTVFLGlobalContext.shared?.overridingVariables
        {
            let existedOverridingNames = Set(overridingVariables.keys)
            
            return existedInlineNames.union(existedOverridingNames)
        }
        
        return existedInlineNames
    }
    
    internal var _nameForVariable: [CTVFLVariable : String] = [:]
    
    internal init() { }
    
    // MARK: Managing Context Stack
    @discardableResult
    internal static func _push() -> CTVFLInlineContext {
        let pushed = CTVFLInlineContext()
        _contexts.append(pushed)
        return pushed
    }
    
    @discardableResult
    internal static func _pop() -> CTVFLInlineContext {
        return _contexts.removeLast()
    }
    
    internal static var _shared: CTVFLInlineContext? {
        return _contexts.last
    }
    
    internal static private(set) var _contexts: [CTVFLInlineContext] = []
}

internal let alphabet =
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

internal let alphanumeric =
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

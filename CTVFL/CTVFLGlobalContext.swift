//
//  CTVFLGlobalContext.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

internal class CTVFLGlobalContext {
    // MARK: Managing Overriding Variable Names
    internal func setOverridingName(
        _ name: String,
        for variable: CTVFLVariable
        )
    {
        overridingNameForVariable[variable] = name
    }
    
    internal func overridingName(for variable: CTVFLVariable) -> String? {
        if let existedName = overridingNameForVariable[variable] {
            return existedName
        } else {
            return nil
        }
    }
    
    internal var overridingNameForVariable: [CTVFLVariable : String] = [:]
    
    internal var overridingVariables: [String: CTVFLVariable] {
        var variables = [String: CTVFLVariable]()
        for (variable, name) in overridingNameForVariable {
            variables[name] = variable
        }
        return variables
    }
    
    // MARK: Managing Constraints
    internal var constraints: [CTVFLConstraint] { return _cosntraints_ }
    
    private var _cosntraints_: [CTVFLConstraint]
    
    internal func registerConstraints<C, V>(
        _ constraints: C,
        with views: V
        ) where
        C: Sequence, C.Element == Constraint,
        V: Sequence, V.Element == View
    {
        for eachView in views {
            if eachView.translatesAutoresizingMaskIntoConstraints {
                eachView.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
        if let hostView = views._commonAncestor {
            let installables: [CTVFLConstraint] = constraints.map {
                .init(view: hostView, constraint: $0)
            }
            _cosntraints_.append(contentsOf: installables)
        } else {
            debugPrint(
                """
                No common super view found for constraints:
                \(Array(constraints)). Candidates: \(views).
                """
            )
        }
    }
    
    // MARK: Managing Context Stack
    @discardableResult
    internal static func push() -> CTVFLGlobalContext {
        let pushed = CTVFLGlobalContext()
        contexts.append(pushed)
        return pushed
    }
    
    @discardableResult
    internal static func pop() -> CTVFLGlobalContext {
        return contexts.removeLast()
    }
    
    internal static var shared: CTVFLGlobalContext? {
        return contexts.last
    }
    
    internal static private(set) var contexts: [CTVFLGlobalContext] = []
    
    internal init() {
        _cosntraints_ = []
    }
}

//
//  _CTVFLTransaction.swift
//  CTVFL
//
//  Created on 2019/3/26.
//


internal class _CTVFLTransaction {
    // MARK: Managing Overriding Layoutable Names
    internal func setOverridingName(
        _ name: String,
        for layoutable: CTVFLLayoutable
        )
    {
        overridingNameForLayoutable[layoutable] = name
    }
    
    internal func overridingName(for layoutable: CTVFLLayoutable) -> String? {
        if let existedName = overridingNameForLayoutable[layoutable] {
            return existedName
        } else {
            return nil
        }
    }
    
    internal var overridingNameForLayoutable: [CTVFLLayoutable : String] = [:]
    
    internal var overridingLayoutables: [String: CTVFLLayoutable] {
        var layoutables = [String: CTVFLLayoutable]()
        for (layoutable, name) in overridingNameForLayoutable {
            layoutables[name] = layoutable
        }
        return layoutables
    }
    
    // MARK: Managing Constraints
    internal var constraints: [_CTVFLConstraint] { return _cosntraints_ }
    
    private var _cosntraints_: [_CTVFLConstraint]
    
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
            let installables: [_CTVFLConstraint] = constraints.map {
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
    internal static func push() -> _CTVFLTransaction {
        let pushed = _CTVFLTransaction()
        contexts.append(pushed)
        return pushed
    }
    
    @discardableResult
    internal static func pop() -> _CTVFLTransaction {
        return contexts.removeLast()
    }
    
    internal static var shared: _CTVFLTransaction? {
        return contexts.last
    }
    
    internal static private(set) var contexts: [_CTVFLTransaction] = []
    
    internal init() {
        _cosntraints_ = []
    }
}

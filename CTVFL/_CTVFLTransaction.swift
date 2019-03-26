//
//  _CTVFLTransaction.swift
//  CTVFL
//
//  Created on 2019/3/26.
//


internal class _CTVFLTransaction {
    // MARK: Managing Constraints
    internal var constraints: [_CTVFLConstraint] { return _cosntraints_ }
    
    private var _cosntraints_: [_CTVFLConstraint]
    
    internal func pushConstraints<C>(_ constraints: C) where
        C: Sequence, C.Element == CTVFLConstraint
    {
        var views = Set<CTVFLView>()
        
        for eachConstraint in constraints {
            let firstViewOrNil = eachConstraint.firstItem as? CTVFLView
            let secondViewOrNil = eachConstraint.secondItem as? CTVFLView
            
            if let firstView = firstViewOrNil {
                if firstView.translatesAutoresizingMaskIntoConstraints {
                    firstView.translatesAutoresizingMaskIntoConstraints = false
                }
                views.insert(firstView)
            }
            
            if let secondView = secondViewOrNil {
                if secondView.translatesAutoresizingMaskIntoConstraints {
                    secondView.translatesAutoresizingMaskIntoConstraints = false
                }
                views.insert(secondView)
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

//
//  _CTVFLTransaction.swift
//  CTVFL
//
//  Created on 2019/3/26.
//


internal class _CTVFLTransaction {
    // MARK: Managing Constraint Handlers
    internal var handlers: ContiguousArray<_CTVFLConstraintHandler> {
        return _handlers_
    }
    
    private var _handlers_: ContiguousArray<_CTVFLConstraintHandler>
    
    internal func pushConstraints<C>(_ constraints: C) where
        C: Sequence, C.Element == CTVFLConstraint
    {
        var cachedCommonAncestors = [[CTVFLView] : CTVFLView]()
        
        for eachConstraint in constraints {
            if let firstView = eachConstraint.firstItem as? CTVFLView {
                firstView.translatesAutoresizingMaskIntoConstraints = false
                
                if let secondView = eachConstraint.secondItem as? CTVFLView {
                    secondView.translatesAutoresizingMaskIntoConstraints = false
                    
                    let views = [firstView, secondView]
                    
                    if let commonAncestor = cachedCommonAncestors[views]
                        ?? views._commonAncestor
                    {
                        cachedCommonAncestors[views] = commonAncestor
                        let handler = _CTVFLConstraintHandler(
                            view: commonAncestor,
                            constraint: eachConstraint
                        )
                        _handlers_.append(handler)
                    } else {
                        debugPrint(
                            """
                            No common super view found for constraint:
                            \(eachConstraint). Candidate views: \(views).
                            """
                        )
                    }
                } else {
                    let handler = _CTVFLConstraintHandler(
                        view: firstView,
                        constraint: eachConstraint
                    )
                    _handlers_.append(handler)
                }
            } else {
                debugPrint("Invalid constraint: \(eachConstraint).")
            }
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
        _handlers_ = []
    }
}

//
//  _CTVFLTransaction.swift
//  CTVFL
//
//  Created on 2019/3/26.
//


internal class _CTVFLTransaction {
    typealias _Constraints = ContiguousArray<_CTVFLConstraint>
    
    // MARK: Managing Constraints
    internal var constraints: _Constraints { return _cosntraints_ }
    
    private var _cosntraints_: _Constraints
    
    internal func pushConstraints<C>(_ constraints: C) where
        C: Sequence, C.Element == CTVFLConstraint
    {
        typealias CTVFLConstraints = ContiguousArray<CTVFLConstraint>
        
        var views = Set<CTVFLView>()
        
        var remoteConstraints = CTVFLConstraints()
        var localConstraints = CTVFLConstraints()
        
        for eachConstraint in constraints {
            let firstViewOrNil = eachConstraint.firstItem as? CTVFLView
            let secondViewOrNil = eachConstraint.secondItem as? CTVFLView
            
            if let firstView = firstViewOrNil, !views.contains(firstView) {
                firstView.translatesAutoresizingMaskIntoConstraints = false
                views.insert(firstView)
            }
            
            if let secondView = secondViewOrNil, !views.contains(secondView) {
                secondView.translatesAutoresizingMaskIntoConstraints = false
                views.insert(secondView)
            }
            
            if eachConstraint.secondItem == nil {
                localConstraints.append(eachConstraint)
            } else {
                remoteConstraints.append(eachConstraint)
            }
        }
        
        if !remoteConstraints.isEmpty {
            if let hostView = views._commonAncestor {
                let installables = remoteConstraints.map {
                    _CTVFLConstraint(view: hostView, constraint: $0)
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
        
        if !localConstraints.isEmpty {
            let installables = localConstraints.map{
                _CTVFLConstraint(constraint: $0)
            }
            _cosntraints_.append(contentsOf: installables)
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

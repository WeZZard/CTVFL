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
        var cachedCommonAncestryViews = [_NSLayoutConstraintItemsKey : CTVFLView]()
        
        for eachConstraint in constraints {
            if let firstItem = eachConstraint.___ctvfl_firstItem {
                if let secondItem = eachConstraint.___ctvfl_secondItem {
                    let firstView = firstItem as? CTVFLView
                    let secondView = secondItem as? CTVFLView
                    
                    let views = [firstView, secondView].compactMap({$0})
                    
                    let itemsKey = _NSLayoutConstraintItemsKey(items: views)
                    
                    if let commonAncestryView = cachedCommonAncestryViews[_NSLayoutConstraintItemsKey(items: views)]
                        ?? views._commonAncestor
                    {
                        if commonAncestryView !== firstView {
                            firstView?.translatesAutoresizingMaskIntoConstraints = false
                        }
                        
                        if commonAncestryView !== secondView {
                            secondView?.translatesAutoresizingMaskIntoConstraints = false
                        }
                        
                        cachedCommonAncestryViews[itemsKey] = commonAncestryView
                        let handler = _CTVFLConstraintHandler(
                            view: commonAncestryView,
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
                    let firstViewOrNil = firstItem as? CTVFLView
                    
                    if let targetView = firstViewOrNil {
                        targetView.translatesAutoresizingMaskIntoConstraints = false
                        
                        let handler = _CTVFLConstraintHandler(
                            view: targetView,
                            constraint: eachConstraint
                        )
                        _handlers_.append(handler)
                    } else {
                        debugPrint(
                            """
                            No super view found for constraint: \(eachConstraint).
                            """
                        )
                    }
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

internal struct _NSLayoutConstraintItemsKey: Hashable {
    
    let items: [CTVFLNSLayoutConstrained]
    
    let hashValue: Int
    
    init(items: [CTVFLNSLayoutConstrained]) {
        var hasher = Hasher()
        for each in items {
            hasher.combine(ObjectIdentifier(each).hashValue)
        }
        hashValue = hasher.finalize()
        self.items = items
    }
    
    static func == (lhs: _NSLayoutConstraintItemsKey, rhs: _NSLayoutConstraintItemsKey) -> Bool {
        if lhs.hashValue == rhs.hashValue {
            if lhs.items.count == rhs.items.count {
                return lhs.items.elementsEqual(rhs.items, by: ===)
            }
        }
        return false
    }
}

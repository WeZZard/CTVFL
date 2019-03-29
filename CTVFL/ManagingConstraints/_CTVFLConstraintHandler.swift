//
//  _CTVFLConstraintHandler.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

internal class _CTVFLConstraintHandler {
    // Set to unowned to avoid a retain cycle on the associated view.
    internal unowned let view: CTVFLView
    
    internal let constraint: CTVFLConstraint
    
    internal func install() {
        view.addConstraint(constraint)
    }
    
    internal func uninstall() {
        view.removeConstraint(constraint)
    }
    
    @available(macOS, introduced: 10.10)
    @available(macOSApplicationExtension, introduced: 10.10)
    internal var isActive: Bool {
        get { return constraint.isActive }
        set { constraint.isActive = newValue }
    }
    
    internal init(view: CTVFLView, constraint: CTVFLConstraint) {
        self.view = view
        self.constraint = constraint
    }
    
    internal static func makeHandlers<C>(constraints: C)
        -> ContiguousArray<_CTVFLConstraintHandler> where
        C: Sequence, C.Element == CTVFLConstraint
    {
        var handlers = ContiguousArray<_CTVFLConstraintHandler>()
        
        var cachedCommonAncestryViews = [_ConstraintsKey : CTVFLView]()
        
        for eachConstraint in constraints {
            if let firstItem = eachConstraint.___ctvfl_firstItem {
                if let secondItem = eachConstraint.___ctvfl_secondItem {
                    let firstView = firstItem as? CTVFLView
                    let secondView = secondItem as? CTVFLView
                    
                    let views = [firstView, secondView].compactMap({$0})
                    
                    let itemsKey = _ConstraintsKey(items: views)
                    
                    if let commonAncestryView = cachedCommonAncestryViews[_ConstraintsKey(items: views)]
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
                        handlers.append(handler)
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
                        handlers.append(handler)
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
        
        return handlers;
    }
    
    internal struct _ConstraintsKey: Hashable {
        
        let items: [CTVFLLayoutAnchorSelectable]
        
        internal func hash(into hasher: inout Hasher) {
            for each in items {
                hasher.combine(ObjectIdentifier(each).hashValue)
            }
        }
        
        init(items: [CTVFLLayoutAnchorSelectable]) {
            self.items = items
        }
        
        static func == (lhs: _ConstraintsKey, rhs: _ConstraintsKey) -> Bool {
            if lhs.hashValue == rhs.hashValue {
                if lhs.items.count == rhs.items.count {
                    return lhs.items.elementsEqual(rhs.items, by: ===)
                }
            }
            return false
        }
    }

}


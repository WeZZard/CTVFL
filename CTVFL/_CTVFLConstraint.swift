//
//  _CTVFLConstraint.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

internal class _CTVFLConstraint {
    // Set to unowned to avoid a retain cycle on the associated view.
    internal unowned var view: CTVFLView
    
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
    
    /// Remote constraint.
    ///
    internal init(view: CTVFLView, constraint: CTVFLConstraint) {
        self.view = view
        self.constraint = constraint
    }
    
    /// Local constraint.
    ///
    internal init(constraint: CTVFLConstraint) {
        self.view = constraint.firstItem as! CTVFLView
        self.constraint = constraint
    }
}


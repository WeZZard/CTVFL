//
//  CTVFLConstraintGroup.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

public class CTVFLConstraintGroup {
    internal private(set) var _constraints: [_CTVFLConstraint]
    
    /// The active state of the contained constraints.
    @available(macOS, introduced: 10.10)
    @available(macOSApplicationExtension, introduced: 10.10)
    public func setActive(_ active: Bool) {
        for constraint in _constraints {
            constraint.isActive = active
        }
    }
    
    @available(macOS, introduced: 10.10)
    @available(macOSApplicationExtension, introduced: 10.10)
    public var areAllAcrive: Bool {
        return _constraints.isEmpty
            ? false
            : _constraints.map({ $0.isActive }).reduce(true, { $0 && $1 })
    }
    
    internal init() {
        _constraints = []
    }
    
    internal func _replaceConstraints(
        _ constraints: [_CTVFLConstraint]
        )
    {
        uninstall()
        
        _constraints = constraints
        
        install()
    }
    
    public func uninstall() {
        for constraint in _constraints {
            constraint.uninstall()
        }
    }
    
    public func install() {
        for constraint in _constraints {
            constraint.install()
        }
    }
}

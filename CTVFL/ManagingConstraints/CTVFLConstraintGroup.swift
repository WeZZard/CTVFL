//
//  CTVFLConstraintGroup.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

public class CTVFLConstraintGroup {
    internal var _handlers: ContiguousArray<_CTVFLConstraintHandler> {
        return _handlers_
    }
    
    @usableFromInline
    internal var _handlers_: ContiguousArray<_CTVFLConstraintHandler>
    
    public init<C: Sequence>(constraints: C) where
        C.Element == CTVFLConstraint
    {
        _handlers_ = _CTVFLConstraintHandler.makeHandlers(
            constraints: constraints
        )
    }
    
    /// The active state of the contained constraints.
    @available(macOS, introduced: 10.10)
    @available(macOSApplicationExtension, introduced: 10.10)
    public func setActive(_ active: Bool) {
        for constraint in _handlers {
            constraint.isActive = active
        }
    }
    
    @available(macOS, introduced: 10.10)
    @available(macOSApplicationExtension, introduced: 10.10)
    public var areAllActive: Bool {
        return _handlers.isEmpty
            ? false
            : _handlers.map({ $0.isActive }).reduce(true, { $0 && $1 })
    }
    
    @inlinable
    internal init() {
        _handlers_ = []
    }
    
    @usableFromInline
    internal func _replaceConstraintHandlers(
        _ constraintHandlers: ContiguousArray<_CTVFLConstraintHandler>
        )
    {
        uninstall()
        
        _handlers_ = constraintHandlers
        
        install()
    }
    
    public func uninstall() {
        for handler in _handlers {
            handler.uninstall()
        }
    }
    
    public func install() {
        for handler in _handlers {
            handler.install()
        }
    }
}

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
    
    private var _handlers_: ContiguousArray<_CTVFLConstraintHandler>
    
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
    public var areAllAcrive: Bool {
        return _handlers.isEmpty
            ? false
            : _handlers.map({ $0.isActive }).reduce(true, { $0 && $1 })
    }
    
    internal init() {
        _handlers_ = []
    }
    
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

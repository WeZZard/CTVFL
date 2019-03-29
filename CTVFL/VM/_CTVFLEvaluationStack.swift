//
//  _CTVFLEvaluationStack.swift
//  CTVFL
//
//  Created on 2019/3/29.
//


internal class _CTVFLEvaluationStack {
    internal typealias _Buffer = UnsafeMutablePointer<_CTVFLEvaluationStackLevel>
    internal var _buffer: _Buffer
    
    internal var _count: Int
    
    internal var _capacity: Int
    
    internal init() {
        let buffer = _Buffer.allocate(capacity: 10)
        buffer.initialize(repeating: .init(), count: 10)
        _buffer = buffer
        _count = 0
        _capacity = 10
    }
    
    deinit {
        _buffer.deallocate()
    }
    
    internal var level: Int {
        return _count
    }
    
    internal func push() {
        let nextLevelIndex = _count
        if _capacity < nextLevelIndex {
            let enlargedCapacity = Int(Float(_capacity) * 1.3)
            let oldBuffer = _buffer
            let newBuffer = _Buffer.allocate(capacity: enlargedCapacity)
            newBuffer.initialize(repeating: .init(), count: enlargedCapacity)
            newBuffer.moveAssign(from: oldBuffer, count: _capacity)
            oldBuffer.deallocate()
            _buffer = newBuffer
            _capacity = enlargedCapacity
        }
        _buffer[nextLevelIndex] = _CTVFLEvaluationStackLevel()
        _count += 1
    }
    
    internal func pop() -> _CTVFLEvaluationStackLevel {
        let poppedLevelIndex = _count - 1
        let poppedLevel = _buffer[poppedLevelIndex]
        _count -= 1
        return poppedLevel
    }
    
    internal func peek() -> _CTVFLEvaluationStackLevel {
        let topLevelIndex = _count - 1
        return _buffer[topLevelIndex]
    }
    
    internal func modifyTopLevel(with closure: (inout _CTVFLEvaluationStackLevel) -> Void) {
        closure(&_buffer[_count - 1])
    }
    
    @inline(__always)
    internal func _indexExceedsStackBounds(_ index: Int) -> Never {
        NSException(
            name: .invalidArgumentException,
            reason: "Index(\(index)) exceeds the stack bounds(\(level))."
        ).raise()
        exit(1)
    }
}

internal struct _CTVFLEvaluationStackLevel {
    var firstItem: CTVFLOpcode.Item? = nil
    var firstAttribute: CTVFLLayoutAttribute? = nil
    var secondItem: CTVFLOpcode.Item? = nil
    var secondAttribute: CTVFLLayoutAttribute? = nil
    var relation: CTVFLLayoutRelation? = nil
    var constant: CTVFLConstant? = nil
    var usesSystemSpace: Bool = false
    var priority: CTVFLPriority = .required
    var evaluationSite: CTVFLOpcode.EvaluationSite = .firstItem
    var retVal: CTVFLOpcode.Item? = nil
}

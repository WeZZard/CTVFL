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
            // Bitwise 1.5x enlarging.
            //
            // I picked 1.5 such that the OS may have an opportunity to
            // reuse memory spaces which have been allocated for past
            // reallocations after several reallocations.
            //
            // Initial allocation:   1  2
            // First re-allocation:  .  .  1  2  3
            // Second re-allocation: .  .  .  .  .  1  2  3  4  5
            // Third re-allocation:  .  .  .  .  .  .  .  .  .  .  1  2  3  4  5  6  7  8
            // Fourth re-allocation: .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 1 2 3 4 5 6 7 8 9 A B C
            // Fivth re-allocation:  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F  11 12
            //
            let enlargedCapacity = _capacity + ((_capacity + 1) >> 1)
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
    internal var firstItem: CTVFLOpcode.Item? = nil
    internal var firstAttribute: CTVFLLayoutAttribute? = nil
    internal var secondItem: CTVFLOpcode.Item? = nil
    internal var secondAttribute: CTVFLLayoutAttribute? = nil
    internal var relation: CTVFLLayoutRelation? = nil
    internal var constant: CGFloat = 0
    internal var usesSystemSpace: Bool = false
    internal var priority: CTVFLPriority = .required
    internal var lhsItem: CTVFLOpcode.Item? = nil
    internal var rhsItem: CTVFLOpcode.Item? = nil
}

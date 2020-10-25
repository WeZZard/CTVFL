//
//  _CTVFLEvaluationStack.swift
//  CTVFL
//
//  Created on 2019/3/29.
//


internal class _CTVFLEvaluationStack {
    @inline(__always)
    internal static var _levelStride: Int {
        return MemoryLayout<_CTVFLEvaluationStackLevel>.stride
    }
    
    internal var _buffer: UnsafeMutableRawPointer?
    
    internal var _count: Int
    
    internal var _capacity: Int
    
    internal init() {
        _buffer = nil
        _count = 0
        _capacity = 0
    }
    
    deinit {
        if let buffer = _buffer {
            buffer.deallocate()
        }
    }
    
    internal var level: Int {
        return _count
    }
    
    internal func push() {
        let index = _count
        
        reallocIfNeeded(index + 1)
        
        guard let buffer = _buffer else {
            preconditionFailure()
        }
        
        let offsetInBytes = index * Self._levelStride
        
        buffer.advanced(by: offsetInBytes)
            .assumingMemoryBound(to: _CTVFLEvaluationStackLevel.self)
            .initialize(to: .init())
        
        _count += 1
    }
    
    @inline(__always)
    internal func reallocIfNeeded(_ wantedCapacity: Int) {
        if wantedCapacity > _capacity {
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
            let newCapacity = _capacity + max(_capacity >> 1, 1)
            let newSize = newCapacity * Self._levelStride
            let goodNewSize = malloc_good_size(newSize)
            let goodNewCapacity = goodNewSize / Self._levelStride
            if malloc_size(_buffer) < goodNewSize {
                let newBuffer = realloc(_buffer, goodNewSize)
                _buffer = newBuffer
                _capacity = goodNewCapacity
            }
        }
    }
    
    internal func pop() -> _CTVFLEvaluationStackLevel {
        guard let buffer = _buffer else {
            preconditionFailure()
        }
        
        let index = _count - 1
        
        let offsetInBytes = index * Self._levelStride
        
        let popped = buffer.advanced(by: offsetInBytes)
            .load(as: _CTVFLEvaluationStackLevel.self)
        
        _count -= 1
        
        return popped
    }
    
    internal func peek() -> _CTVFLEvaluationStackLevel {
        guard let buffer = _buffer else {
            preconditionFailure()
        }
        
        let index = _count - 1
        
        let offsetInBytes = index * Self._levelStride
        
        return buffer.advanced(by: offsetInBytes)
            .load(as: _CTVFLEvaluationStackLevel.self)
    }
    
    @inline(__always)
    internal func modifyTopLevel(with closure: (inout _CTVFLEvaluationStackLevel) -> Void) {
        guard let buffer = _buffer else {
            preconditionFailure()
        }
        
        let index = _count - 1
        
        let offsetInBytes = index * Self._levelStride
        
        closure(&buffer.advanced(by: offsetInBytes).assumingMemoryBound(to: _CTVFLEvaluationStackLevel.self).pointee)
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

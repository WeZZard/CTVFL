//
//  _CTVFLEvaluationStack.swift
//  CTVFL
//
//  Created on 2019/3/29.
//


internal class _CTVFLEvaluationStack {
    internal typealias _Buffer = ManagedBuffer<_CTVFLEvaluationStackMetadata, _CTVFLEvaluationStackLevel>
    internal var _buffer: Unmanaged<_Buffer>
    
    internal init() {
        let buffer = _Buffer.create(minimumCapacity: 10, makingHeaderWith: {
            (buffer) -> _CTVFLEvaluationStackMetadata in
            return _CTVFLEvaluationStackMetadata(levelCount: 0)
        })
        _buffer = Unmanaged.passRetained(buffer)
    }
    
    deinit {
        _buffer.release()
    }
    
    internal var level: Int {
        return _buffer.takeUnretainedValue().header.levelCount
    }
    
    internal func push() {
        let currentLevelCount = _buffer.takeUnretainedValue().header.levelCount
        let nextLevelIndex = _buffer.takeUnretainedValue().header.levelCount
        if _buffer.takeUnretainedValue().capacity < nextLevelIndex {
            let enlargedCapacity = Int(Float(_buffer.takeUnretainedValue().capacity) * 1.3)
            let oldBuffer = _buffer
            let newBuffer = _Buffer.create(minimumCapacity: enlargedCapacity, makingHeaderWith: {
                (newBuffer) -> _CTVFLEvaluationStackMetadata in
                newBuffer.withUnsafeMutablePointerToElements({$0}).moveAssign(
                    from: oldBuffer.takeUnretainedValue().withUnsafeMutablePointerToElements({$0}),
                    count: oldBuffer.takeUnretainedValue().capacity
                )
                return _CTVFLEvaluationStackMetadata(levelCount: currentLevelCount)
            })
            oldBuffer.release()
            _buffer = .passRetained(newBuffer)
        }
        _buffer.takeUnretainedValue().withUnsafeMutablePointerToElements({$0[nextLevelIndex] = .init()})
        _buffer.takeUnretainedValue().header.levelCount += 1
    }
    
    internal func pop() -> _CTVFLEvaluationStackLevel {
        let poppedLevelIndex = _buffer.takeUnretainedValue().header.levelCount - 1
        let poppedLevel = _buffer.takeUnretainedValue().withUnsafeMutablePointerToElements({
            $0[poppedLevelIndex]
        })
        _buffer.takeUnretainedValue().header.levelCount -= 1
        return poppedLevel
    }
    
    internal subscript(index: Int) -> _CTVFLEvaluationStackLevel {
        get {
            if index < level {
                return _buffer.takeUnretainedValue().withUnsafeMutablePointerToElements({$0[index]})
            } else {
                _indexExceedsStackBounds(index)
            }
        }
        set {
            if index < level {
                _buffer.takeUnretainedValue().withUnsafeMutablePointerToElements({
                    $0[index]=newValue
                })
            } else {
                _indexExceedsStackBounds(index)
            }
        }
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

internal struct _CTVFLEvaluationStackMetadata {
    internal var levelCount: Int
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

//
//  _CTVFLEvaluationStack.swift
//  CTVFL
//
//  Created on 2019/3/29.
//


internal class _CTVFLEvaluationStack {
    internal var _buffer: ManagedBuffer<_CTVFLEvaluationStackMetadata, _CTVFLEvaluationStackLevel>
    
    internal init() {
        _buffer = .create(minimumCapacity: 10, makingHeaderWith: {
            (buffer) -> _CTVFLEvaluationStackMetadata in
            return _CTVFLEvaluationStackMetadata(levelCount: 0)
        })
    }
    
    internal func push() {
        let currentLevelCount = _buffer.header.levelCount
        let nextLevelIndex = _buffer.header.levelCount
        if _buffer.capacity < nextLevelIndex {
            let enlargedCapacity = Int(Float(_buffer.capacity) * 1.3)
            let oldBuffer = _buffer
            _buffer = .create(minimumCapacity: enlargedCapacity, makingHeaderWith: {
                (newBuffer) -> _CTVFLEvaluationStackMetadata in
                newBuffer.withUnsafeMutablePointerToElements({$0}).moveAssign(
                    from: oldBuffer.withUnsafeMutablePointerToElements({$0}),
                    count: oldBuffer.capacity
                )
                return _CTVFLEvaluationStackMetadata(levelCount: currentLevelCount)
            })
        }
        _buffer.withUnsafeMutablePointerToElements({$0[nextLevelIndex] = .init()})
        _buffer.header.levelCount += 1
    }
    
    internal func pop() -> _CTVFLEvaluationStackLevel {
        let poppedLevelIndex = _buffer.header.levelCount - 1
        let poppedLevel = _buffer.withUnsafeMutablePointerToElements({
            $0[poppedLevelIndex]
        })
        _buffer.header.levelCount -= 1
        return poppedLevel
    }
    
    internal subscript(index: Int) -> _CTVFLEvaluationStackLevel {
        get {
            if index < _buffer.header.levelCount {
                return _buffer.withUnsafeMutablePointerToElements({$0[index]})
            } else {
                _indexExceedsStackBounds(index)
            }
        }
        set {
            if index < _buffer.header.levelCount {
                _buffer.withUnsafeMutablePointerToElements({
                    $0[index]=newValue
                })
            } else {
                _indexExceedsStackBounds(index)
            }
        }
    }
    
    internal func _indexExceedsStackBounds(_ index: Int) -> Never {
        NSException(
            name: .invalidArgumentException,
            reason: "Index(\(index)) exceeds the stack bounds(\(_buffer.header.levelCount))."
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

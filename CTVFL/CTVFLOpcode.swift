//
//  CTVFLOpcode.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public enum CTVFLOpcode {
    case push
    case pop
    case moveItem(CTVFLItem)
    case moveAttribute(CTVFLLayoutAttribute)
    case moveRelation(CTVFLLayoutRelation)
    case moveConstant(CTVFLConstant)
    case moveUsesSystemSpace(Bool)
    case movePriority(CTVFLPriority)
    case moveReturnValue(ReturnValue)
    case moveEvaluationSite(EvaluationSite)
    case makeConstraint
    
    public enum ReturnValue {
        case firstItem
        case secondItem
    }
    
    public enum EvaluationSite {
        case firstItem
        case secondItem
    }
}

extension ContiguousArray where Element == CTVFLOpcode {
    internal mutating func _ensureTailElements(_ addition: Int) {
        let targetCapacity = Swift.max(100, count + addition)
        if capacity < targetCapacity {
            reserveCapacity(targetCapacity)
        }
    }
}

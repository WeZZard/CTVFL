//
//  CTVFLOpcode.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public enum CTVFLOpcode {
    case push
    case pop
    case moveItem(Item)
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
    
    public enum Item {
        case container
        case confinable(CTVFLConfinable)
        case layoutable(CTVFLLayoutable)
        
        internal func _getAnchorSelector(with another: Item?) -> CTVFLLayoutAnchorSelectable? {
            switch (self, another) {
            case let (.layoutable(layoutable), _):
                return layoutable._asAnchorSelector
            case let (.confinable(confinable), _):
                return confinable._asAnchorSelector
            case let (.container, .some(.layoutable(layoutable))):
                return (layoutable._asAnchorSelector as? CTVFLView)?.superview
            default:
                return nil
            }
        }
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

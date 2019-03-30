//
//  CTVFLOpcode.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public enum CTVFLOpcode {
    case push
    case pop
    case moveFirstItem(Item)
    case moveFirstItemFromRetVal(EvaluationSite)
    case moveFirstAttribute(CTVFLLayoutAttribute)
    case moveFirstAttributeFromRetVal(EvaluationSite)
    case moveSecondItem(Item)
    case moveSecondItemFromRetVal(EvaluationSite)
    case moveSecondAttribute(CTVFLLayoutAttribute)
    case moveSecondAttributeFromRetVal(EvaluationSite)
    case moveRelation(CTVFLLayoutRelation)
    case moveReleationFromRetVal
    case moveConstant(CGFloat)
    case moveConstantFromRetVal
    case moveUsesSystemSpace(Bool)
    case movePriority(CTVFLPriority)
    case movePriorityFromRetVal
    case makeConstraint
    
    public enum EvaluationSite {
        case first
        case second
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

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
    case moveFirstItemFromRetVal(ItemIndex)
    case moveFirstAttribute(CTVFLLayoutAttribute)
    case moveFirstAttributeFromRetVal(AttributeIndex)
    case moveSecondItem(Item)
    case moveSecondItemFromRetVal(ItemIndex)
    case moveSecondAttribute(CTVFLLayoutAttribute)
    case moveSecondAttributeFromRetVal(AttributeIndex)
    case moveRelation(CTVFLLayoutRelation)
    case moveReleationFromRetVal
    case moveConstant(CGFloat)
    case moveConstantFromRetVal
    case moveUsesSystemSpace(Bool)
    case movePriority(CTVFLPriority)
    case movePriorityFromRetVal
    case moveLhsItem(Item)
    case moveLhsItemFromRetValLhsItem
    case moveRhsItem(Item)
    case moveRhsItemFromRetValRhsItem
    case makeConstraint
    
    public enum AttributeIndex {
        case first
        case second
    }
    
    public enum ItemIndex {
        case lhs
        case rhs
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

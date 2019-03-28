//
//  CTVFLItem.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

public enum CTVFLItem {
    case container
    case confinable(CTVFLConfinable)
    case layoutable(CTVFLLayoutable)
    
    internal var _layoutable: CTVFLLayoutable? {
        switch self {
        case let .layoutable(layoutable): return layoutable
        default: return nil
        }
    }
    
    internal func _getAnchorSelector(with another: CTVFLItem?) -> CTVFLLayoutAnchorSelectable? {
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

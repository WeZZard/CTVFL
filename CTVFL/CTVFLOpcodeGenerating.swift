//
//  CTVFLOpcodeGenerating.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

// MARK: - CTVFLOpcodeGenerating
public protocol CTVFLOpcodeGenerating {
    func generateOpcodes(forOrientation orientation: CTVFLLayoutAnchorSelectableOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>)
}

// MARK: - CTVFLOpcode
public enum CTVFLOpcode {
    case push
    case pop
    case moveItem(CTVFLItem)
    case moveAttribute(CTVFLLayoutAttribute)
    case moveRelation(CTVFLLayoutRelation)
    case moveConstant(CTVFLConstant)
    case movePriority(CTVFLPriority)
    case loadLhsItem
    case loadRhsItem
}

extension ContiguousArray where Element == CTVFLOpcode {
    @inline(__always)
    internal mutating func _ensureTailElements(_ addition: Int) {
        let targetCapacity = Swift.max(100, count + addition)
        if capacity < targetCapacity {
            reserveCapacity(targetCapacity)
        }
    }
}

// MARK: - CTVFLItem
public enum CTVFLItem {
    case container
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
            return layoutable._item
        case let (.container, .some(.layoutable(layoutable))):
            return (layoutable._item as? CTVFLView)?.superview
        default:
            return nil
        }
    }
}

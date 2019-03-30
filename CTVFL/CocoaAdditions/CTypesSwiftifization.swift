//
//  CTypesSwiftifization.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension CTVFLLayoutAttribute: CustomStringConvertible {
    public var description: String {
        switch self {
        case .bottom: return "Bottom"
        case .centerX: return "CenterX"
        case .centerY: return "CenterY"
        case .firstBaseline: return "FirstBaseline"
        case .height: return "Height"
        case .lastBaseline: return "LastBaseline"
        case .leading: return "Leading"
        case .left: return "Left"
        case .right: return "Right"
        case .top: return "Top"
        case .trailing: return "Trailing"
        case .width: return "Width"
        @unknown default:   fatalError()
        }
    }
}

extension NSLayoutConstraint.Relation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .equal:                return "Equal"
        case .lessThanOrEqual:      return "LessThanOrEqual"
        case .greaterThanOrEqual:   return "GreaterThanOrEqual"
        @unknown default:           fatalError()
        }
    }
}

extension NSLayoutConstraint.Attribute: CustomStringConvertible {
    public var description: String {
        #if os(iOS) || os(tvOS)
        switch self {
        case .bottom:               return "Bottom"
        case .bottomMargin:         return "BottomMargin"
        case .centerX:              return "CenterX"
        case .centerXWithinMargins: return "CenterXWithMargins"
        case .centerY:              return "CenterY"
        case .centerYWithinMargins: return "CenterYWithMargins"
        case .firstBaseline:        return "FirstBaseline"
        case .height:               return "Height"
        case .lastBaseline:         return "LastBaseline"
        case .leading:              return "Leading"
        case .leadingMargin:        return "LeadingMargin"
        case .left:                 return "Left"
        case .leftMargin:           return "LeftMargin"
        case .notAnAttribute:       return "NotAnAttribute"
        case .right:                return "Right"
        case .rightMargin:          return "RightMargin"
        case .top:                  return "Top"
        case .topMargin:            return "TopMargin"
        case .trailing:             return "Trailing"
        case .trailingMargin:       return "TrailingMargin"
        case .width:                return "Width"
        @unknown default:           fatalError()
        }
        #endif
        #if os(macOS)
        switch self {
        case .bottom:           return "Bottom"
        case .centerX:          return "CenterX"
        case .centerY:          return "CenterY"
        case .firstBaseline:    return "FirstBaseline"
        case .height:           return "Height"
        case .lastBaseline:     return "LastBaseline"
        case .leading:          return "Leading"
        case .left:             return "Left"
        case .notAnAttribute:   return "NotAnAttribute"
        case .right:            return "Right"
        case .top:              return "Top"
        case .trailing:         return "Trailing"
        case .width:            return "Width"
        @unknown default:       fatalError()
        }
        #endif
    }
}

extension NSLayoutConstraint.FormatOptions: CustomStringConvertible {
    public var description: String {
        var descriptions = [String]()
        if self.contains(.alignAllBottom) {
            descriptions.append("AlignAllBottom")
        }
        if self.contains(.alignAllTop) {
            descriptions.append("AlignAllTop")
        }
        if self.contains(.alignAllLeft) {
            descriptions.append("AlignAllLeft")
        }
        if self.contains(.alignAllRight) {
            descriptions.append("AlignAllRight")
        }
        if self.contains(.alignAllCenterX) {
            descriptions.append("AlignAllCenterX")
        }
        if self.contains(.alignAllCenterY) {
            descriptions.append("AlignAllCenterY")
        }
        if self.contains(.alignAllLeading) {
            descriptions.append("AlignAllLeading")
        }
        if self.contains(.alignAllTrailing) {
            descriptions.append("AlignAllTrailing")
        }
        if self.contains(.alignAllFirstBaseline) {
            descriptions.append("AlignAllFirstBaseline")
        }
        if self.contains(.alignAllLastBaseline) {
            descriptions.append("AlignAllLastBaseline")
        }
        if self.contains(.directionLeftToRight) {
            descriptions.append("DirectionLeftToRight")
        }
        if self.contains(.directionRightToLeft) {
            descriptions.append("DirectionRightToLeft")
        }
        #if os(iOS) || os(tvOS)
        if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
            if self.contains(.spacingBaselineToBaseline) {
                descriptions.append("SpacingBaselineToBaseline")
            }
        }
        #endif
        return descriptions.joined(separator: ", ")
    }
}

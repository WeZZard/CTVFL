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

extension CTVFLLayoutRelation: CustomStringConvertible {
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

//
//  Misc.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

import CTVFL

#if os(iOS) || os(tvOS)
import UIKit

typealias LayoutAttribute = NSLayoutAttribute
#elseif os(macOS)
import AppKit

typealias LayoutAttribute = NSLayoutConstraint.Attribute
#endif

extension LayoutAttribute: CustomStringConvertible {
    public var description: String {
        #if os(iOS) || os(tvOS)
        switch self {
        case .bottom: return "Bottom"
        case .bottomMargin: return "BottomMargin"
        case .centerX: return "CenterX"
        case .centerXWithinMargins: return "CenterXWithMargins"
        case .centerY: return "CenterY"
        case .centerYWithinMargins: return "CenterYWithMargins"
        case .firstBaseline: return "FirstBaseline"
        case .height: return "Height"
        case .lastBaseline: return "LastBaseline"
        case .leading: return "Leading"
        case .leadingMargin: return "LeadingMargin"
        case .left: return "Left"
        case .leftMargin: return "LeftMargin"
        case .notAnAttribute: return "NotAnAttribute"
        case .right: return "Right"
        case .rightMargin: return "RightMargin"
        case .top: return "Top"
        case .topMargin: return "TopMargin"
        case .trailing: return "Trailing"
        case .trailingMargin: return "TrailingMargin"
        case .width: return "Width"
        }
        #endif
        #if os(macOS)
        switch self {
        case .bottom: return "Bottom"
        case .centerX: return "CenterX"
        case .centerY: return "CenterY"
        case .firstBaseline: return "FirstBaseline"
        case .height: return "Height"
        case .lastBaseline: return "LastBaseline"
        case .leading: return "Leading"
        case .left: return "Left"
        case .notAnAttribute: return "NotAnAttribute"
        case .right: return "Right"
        case .top: return "Top"
        case .trailing: return "Trailing"
        case .width: return "Width"
        }
        #endif
    }
}

extension CTVFLLayoutRelation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .equal: return "Equal"
        case .lessThanOrEqual: return "LessThanOrEqual"
        case .greaterThanOrEqual: return "GreaterThanOrEqual"
        }
    }
}

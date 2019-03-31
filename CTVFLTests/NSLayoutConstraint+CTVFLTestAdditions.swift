//
//  NSLayoutConstraint+CTVFLTestAdditions.swift
//  CTVFL
//
//  Created on 2019/3/31.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSLayoutConstraint {
    internal var _ctvfl_firstAnchor: NSLayoutAnchor<AnyObject>? {
        if #available(macOS 10.12, iOS 10.0, tvOS 10.0, *) {
            return self.firstAnchor
        } else {
            if let object = perform(NSSelectorFromString("firstAnchor")) {
                let anchor = object.takeRetainedValue()
                return unsafeBitCast(anchor, to: NSLayoutAnchor<AnyObject>.self)
            }
            return nil
        }
    }
    
    internal var _ctvfl_secondAnchor: NSLayoutAnchor<AnyObject>? {
        if #available(macOS 10.12, iOS 10.0, tvOS 10.0, *) {
            return self.secondAnchor
        } else {
            if let object = perform(NSSelectorFromString("secondAnchor")) {
                let anchor = object.takeRetainedValue()
                return unsafeBitCast(anchor, to: NSLayoutAnchor<AnyObject>.self)
            }
            return nil
        }
    }
}

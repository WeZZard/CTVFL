//
//  CTVFLWherePredicateContent.swift
//  CTVFL
//
//  Created by WeZZard on 9/21/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public enum CTVFLWherePredicateContent: Equatable {
    case constant(CTVFLConstant)
    case layoutable(CTVFLLayoutable)
    
    public static func == (
        lhs: CTVFLWherePredicateContent,
        rhs: CTVFLWherePredicateContent
        ) -> Bool
    {
        switch (lhs, rhs) {
        case let (.constant(lhs), .constant(rhs)):
            return lhs == rhs
        case let (.layoutable(lhs), .layoutable(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    public func opCodes(for orientation: CTVFLConstraintOrientation)
        -> [CTVFLOpCode]
    {
        switch self {
        case let .constant(constant):
            return [
                .pushConstant(CGFloat(constant.rawValue)),
            ]
        case let .layoutable(layoutable):
            return [
                .pushItem(.view(layoutable._item)),
            ]
        }
    }
}

//
//  CTVFLLexicon.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - CTVFLOperand
public enum CTVFLOpCode {
    case pushItem(CTVFLItem)
    case pushAttribute(LayoutAttribute)
    case pushRelation(LayoutRelation)
    case pushConstant(CGFloat)
    case makeConstraint
    case storeItem
    case loadItem
    case pop
}

public enum CTVFLItem {
    case superview
    case view(View)
    
    var asView: View! {
        switch self {
        case let .view(view): return view
        case .superview: return nil
        }
    }
}

public protocol CTVFLOperand {
    associatedtype LeadingLayoutBoundary: CTVFLSyntaxLayoutBoundary
    associatedtype TrailingLayoutBoundary: CTVFLSyntaxLayoutBoundary
    associatedtype SyntaxEnd: CTVFLSyntaxEnd
    associatedtype SyntaxTermination: CTVFLSyntaxTermination
    
    func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode]
}

// MARK: - CTVFLPopulatableOperand
public enum CTVFLConstraintOrientation {
    case horizontal
    case vertical
}

public protocol CTVFLPopulatableOperand: CTVFLOperand {
    func makeConstraints(orientation: CTVFLConstraintOrientation, options: VFLOptions) -> [Constraint]
}

extension CTVFLPopulatableOperand {
    public func makeConstraints(orientation: CTVFLConstraintOrientation, options: VFLOptions) -> [Constraint] {
        var constraints = [Constraint]()
        var items = [CTVFLItem]()
        var item1: CTVFLItem!, item2: CTVFLItem!
        var attribute1: LayoutAttribute!, attribute2: LayoutAttribute!
        var relation: LayoutRelation!
        var constant: CGFloat!
        var itemIndex = 0, attributeIndex = 0
        for each in opCodes(forOrientation: orientation, withOptions: options) {
            switch each {
            case let .pushItem(item):
                if itemIndex == 0 {
                    item1 = item
                    itemIndex += 1
                } else if itemIndex == 1 {
                    item2 = item
                    itemIndex += 1
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "Invalid item index: \(itemIndex).",
                        userInfo: nil
                    ).raise()
                }
                break
            case let .pushAttribute(attr):
                if attributeIndex == 0 {
                    attribute1 = attr
                    attributeIndex += 1
                } else if attributeIndex == 1 {
                    attribute2 = attr
                    attributeIndex += 1
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "Invalid attribute index: \(attributeIndex).",
                        userInfo: nil
                    ).raise()
                }
                break
            case let .pushRelation(rel):
                relation = rel
                break
            case let .pushConstant(value):
                constant = value
            case .makeConstraint:
                let constraint = NSLayoutConstraint(
                    item: item1!,
                    attribute: attribute1!,
                    relatedBy: relation!,
                    toItem: item2,
                    attribute: attribute2 ?? .notAnAttribute,
                    multiplier: 1,
                    constant: constant ?? 0
                )
                constraints.append(constraint)
            case .pop:
                item1 = nil
                item2 = nil
                attribute1 = nil
                attribute2 = nil
                relation = nil
                constant = nil
                itemIndex = 0
                attributeIndex = 0
            case .storeItem:
                if let item = item2 {
                    items.append(item)
                } else if let item = item1 {
                    items.append(item)
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "No item to store.",
                        userInfo: nil
                    ).raise()
                }
            case .loadItem:
                if itemIndex == 0 {
                    item1 = items.first!
                    itemIndex += 1
                }
                if itemIndex == 1 {
                    item2 = items.first!
                    itemIndex += 1
                }
            }
        }
        if !(item1 == nil
            && item2 == nil
            && attribute1 == nil
            && attribute2 == nil
            && relation == nil
            && constant == nil
            && itemIndex == 0
            && attributeIndex == 0
            )
        {
            NSException(
                name: .internalInconsistencyException,
                reason: "Inconsistent stack. Did you forget pop?",
                userInfo: nil
            ).raise()
        }
        return constraints
    }
}

// MARK: -
// MARK: SyntaxEnd
public protocol CTVFLSyntaxEnd {}

public struct CTVFLSyntaxEndWithLayoutable: CTVFLSyntaxEnd {}

public struct CTVFLSyntaxEndWithConstant: CTVFLSyntaxEnd {}

// MARK: CTVFLSyntaxLayoutBoundary
public protocol CTVFLSyntaxLayoutBoundary {}

public struct CTVFLSyntaxHasLayoutBoundary: CTVFLSyntaxLayoutBoundary {}

public struct CTVFLSyntaxNoLayoutBoundary: CTVFLSyntaxLayoutBoundary {}

// MARK: SyntaxTermination
public protocol CTVFLSyntaxTermination {}

public struct CTVFLSyntaxIsNotTerminated: CTVFLSyntaxTermination {}

public struct CTVFLSyntaxIsTerminated: CTVFLSyntaxTermination {}

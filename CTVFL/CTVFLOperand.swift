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

public enum CTVFLItem {
    case container
    case layoutable(CTVFLLayoutable)
    
    internal var _layoutable: CTVFLLayoutable? {
        switch self {
        case let .layoutable(layoutable): return layoutable
        default: return nil
        }
    }
    
    internal func _getView(with another: CTVFLItem?) -> CTVFLView! {
        switch (self, another) {
        case let (.layoutable(layoutable), _):
            return layoutable._item as? CTVFLView
        case let (.container, .some(.layoutable(layoutable))):
            return (layoutable._item as? CTVFLView)?.superview
        default:
            return nil
        }
    }
}

public protocol CTVFLOperand {
    associatedtype LeadingLayoutBoundary: CTVFLSyntaxLayoutBoundary
    associatedtype TrailingLayoutBoundary: CTVFLSyntaxLayoutBoundary
    associatedtype SyntaxEnd: CTVFLSyntaxEnd
    associatedtype SyntaxTermination: CTVFLSyntaxTermination
    
    func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>)
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

// MARK: - CTVFLPopulatableOperand
public enum CTVFLConstraintOrientation {
    case horizontal
    case vertical
}

public protocol CTVFLPopulatableOperand: CTVFLOperand {
    func makeConstraints(orientation: CTVFLConstraintOrientation, options: CTVFLOptions) -> [CTVFLConstraint]
}

extension CTVFLPopulatableOperand {
    public func makeConstraints(orientation: CTVFLConstraintOrientation, options: CTVFLOptions) -> [CTVFLConstraint] {
        typealias Level = (
            item1: CTVFLItem?,
            attribute1: CTVFLLayoutAttribute?,
            item2: CTVFLItem?,
            attribute2: CTVFLLayoutAttribute?,
            relation: CTVFLLayoutRelation?,
            constant: CTVFLConstant?,
            priority: CTVFLPriority
        )
        
        let emptyLevel: Level = (
            item1: nil,
            attribute1: nil,
            item2: nil,
            attribute2: nil,
            relation: nil,
            constant: nil,
            priority: .required
        )
        
        var stack: ContiguousArray<Level> = [emptyLevel]
        stack.reserveCapacity(10)
        
        var constraints = ContiguousArray<CTVFLConstraint>()
        constraints.reserveCapacity(10)
        
        var itemsToBeAligned = ContiguousArray<AnyObject>()
        itemsToBeAligned.reserveCapacity(10)
        
        let needsAlign = !options.intersection(.alignmentMask).isEmpty
        
        var opcodes = ContiguousArray<CTVFLOpcode>()
        
        self.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &opcodes)
        
        for index in 0..<opcodes.endIndex {
            let eachOpcode = opcodes[index]
            let currentLevel = stack.endIndex - 1
            
            switch eachOpcode {
            case .push:
                stack.append(emptyLevel)
            case .pop:
                let (
                    item1,
                    attribute1,
                    item2,
                    attribute2,
                    relation,
                    constant,
                    priority
                ) = stack.popLast()!
                
                let constraint = NSLayoutConstraint.___ctvfl_constraint(
                    withItem: item1!._getView(with: item2),
                    attribute: attribute1!,
                    relatedBy: relation!,
                    toItem: item2?._getView(with: item1),
                    attribute: attribute2 ?? .notAnAttribute,
                    multiplier: 1,
                    constant: (constant?.rawValue).map({CGFloat($0)}) ?? 0
                )
                constraint.priority = priority
                constraints.append(constraint)
            case let .moveItem(item):
                if needsAlign {
                    switch item {
                    case let .layoutable(layoutable):
                        itemsToBeAligned.append(layoutable._item)
                    default: break
                    }
                }
                
                if stack[currentLevel].item1 == nil {
                    stack[currentLevel].item1 = item
                } else if stack[currentLevel].item2 == nil {
                    stack[currentLevel].item2 = item
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "Items overflow.",
                        userInfo: nil
                    ).raise()
                }
            case let .moveAttribute(attr):
                if stack[currentLevel].attribute1 == nil {
                    stack[currentLevel].attribute1 = attr
                } else if stack[currentLevel].attribute2 == nil {
                    stack[currentLevel].attribute2 = attr
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "Attributes overflow.",
                        userInfo: nil
                    ).raise()
                }
            case let .moveRelation(rel):
                stack[currentLevel].relation = rel
            case let .moveConstant(value):
                stack[currentLevel].constant = value
            case let .movePriority(value):
                stack[currentLevel].priority = value
            case .loadLhsItem:
                let item: CTVFLItem = .layoutable(CTVFLLayoutable(rawValue: constraints.last!.firstItem!))
                if stack[currentLevel].item1 == nil {
                    stack[currentLevel].item1 = item
                } else if stack[currentLevel].item2 == nil {
                    stack[currentLevel].item2 = item
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "Items overflow.",
                        userInfo: nil
                    ).raise()
                }
            case .loadRhsItem:
                let item: CTVFLItem = .layoutable(CTVFLLayoutable(rawValue: constraints.last!.secondItem!))
                if stack[currentLevel].item1 == nil {
                    stack[currentLevel].item1 = item
                } else if stack[currentLevel].item2 == nil {
                    stack[currentLevel].item2 = item
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "Items overflow.",
                        userInfo: nil
                    ).raise()
                }
                break
            }
        }
        
        if needsAlign && itemsToBeAligned.endIndex > 1 {
            let attributes = _attributes(forOptions: options)
            
            for index in 0..<(itemsToBeAligned.endIndex - 1) {
                let firstItem = itemsToBeAligned[index]
                let secondItem = itemsToBeAligned[index + 1]
                
                for eachAttribute in attributes {
                    let constraint = NSLayoutConstraint(
                        item: firstItem,
                        attribute: eachAttribute,
                        relatedBy: .equal,
                        toItem: secondItem,
                        attribute: eachAttribute,
                        multiplier: 1,
                        constant: 0
                    )
                    
                    constraints.append(constraint)
                }
            }
        }
        
        return Array(constraints)
    }
    
    internal func _attributes(forOptions options: CTVFLOptions) -> [CTVFLLayoutAttribute] {
        var attributes = [CTVFLLayoutAttribute]()
        
        if options.contains(.alignAllBottom) {
            attributes.append(.bottom)
        }
        
        if options.contains(.alignAllTop) {
            attributes.append(.top)
        }
        
        if options.contains(.alignAllLeft) {
            attributes.append(.left)
        }
        
        if options.contains(.alignAllRight) {
            attributes.append(.right)
        }
        
        if options.contains(.alignAllCenterX) {
            attributes.append(.centerX)
        }
        
        if options.contains(.alignAllCenterY) {
            attributes.append(.centerY)
        }
        
        if options.contains(.alignAllLeading) {
            attributes.append(.leading)
        }
        
        if options.contains(.alignAllTrailing) {
            attributes.append(.trailing)
        }
        
        if #available(OSXApplicationExtension 10.11, *) {
            if options.contains(.alignAllFirstBaseline) {
                attributes.append(.firstBaseline)
            }
        }
        
        if options.contains(.alignAllLastBaseline) {
            attributes.append(.lastBaseline)
        }
        
        return attributes
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

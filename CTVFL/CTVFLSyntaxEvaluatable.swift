//
//  CTVFLSyntaxEvaluatable.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol CTVFLSyntaxEvaluatable: CTVFLOpcodeGenerating {
    func makeConstraints(orientation: CTVFLNSLayoutConstrainedOrientation, options: CTVFLOptions) -> [CTVFLConstraint]
}

extension CTVFLSyntaxEvaluatable {
    public func makeConstraints(orientation: CTVFLNSLayoutConstrainedOrientation, options: CTVFLOptions) -> [CTVFLConstraint] {
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
                    withItem: item1!._getItem(with: item2)!,
                    attribute: attribute1!,
                    relatedBy: relation!,
                    toItem: item2?._getItem(with: item1),
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
                let item: CTVFLItem = .layoutable(CTVFLLayoutable(rawValue: constraints.last!.___ctvfl_firstItem!))
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
                let item: CTVFLItem = .layoutable(CTVFLLayoutable(rawValue: constraints.last!.___ctvfl_secondItem!))
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

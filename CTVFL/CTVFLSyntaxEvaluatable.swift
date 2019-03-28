//
//  CTVFLSyntaxEvaluatable.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol CTVFLSyntaxEvaluatable: CTVFLOpcodeGenerating {
    func makeConstraints(orientation: CTVFLLayoutAnchorSelectableOrientation, options: CTVFLOptions) -> [CTVFLConstraint]
}

extension CTVFLSyntaxEvaluatable {
    public func makeConstraints(orientation: CTVFLLayoutAnchorSelectableOrientation, options: CTVFLOptions) -> [CTVFLConstraint] {
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
        
        typealias CTVFLConstraintRecord = (
            constraint: CTVFLConstraint,
            lhs: CTVFLLayoutAnchorSelectable?,
            rhs: CTVFLLayoutAnchorSelectable?
        )
        
        var constraints = ContiguousArray<CTVFLConstraintRecord>()
        constraints.reserveCapacity(10)
        
        var itemsToBeAligned = ContiguousArray<CTVFLLayoutAnchorSelectable>()
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
                let topLevel = stack.popLast()!
                let (
                    item1,
                    attribute1,
                    item2,
                    attribute2,
                    relation,
                    constant,
                    priority
                ) = topLevel
                
                let firstSelector = item1?._getAnchorSelector(with: item2)
                
                let secondSelector = item2?._getAnchorSelector(with: item1)
                
                switch (firstSelector, attribute1, secondSelector, attribute2, relation, constant) {
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), .some(c)):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: CGFloat(c.rawValue))
                    constraint.priority = priority
                    constraints.append((constraint, sel1, sel2))
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), .none):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2)
                    constraint.priority = priority
                    constraints.append((constraint, sel1, sel2))
                case let (.some(sel), .some(attr), .none, .none, .some(rel), .some(c)):
                    let anchor = sel._ctvfl_anchor(for: attr)
                    let constraint = anchor._ctvfl_constraint(with: rel, toConstant: CGFloat(c.rawValue))
                    constraint.priority = priority
                    constraints.append((constraint, sel, nil))
                default:
                    debugPrint("Invalid input: Item1 = \(item1.map({"\($0)"}) ?? "nil"); Attribute1 = \(attribute1.map({"\($0)"}) ?? "nil"); Item2 = \(item2.map({"\($0)"}) ?? "nil"); Attribute2 = \(attribute2.map({"\($0)"}) ?? "nil"); Relation = \(relation.map({"\($0)"}) ?? "nil"); Constant = \(constant.map({"\($0)"}) ?? "nil")");
                }
                
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
                let item: CTVFLItem = .layoutable(CTVFLLayoutable(rawValue: constraints.last!.lhs!))
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
                let item: CTVFLItem = .layoutable(CTVFLLayoutable(rawValue: constraints.last!.rhs!))
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
        
        var alignmentConstraints = ContiguousArray<CTVFLConstraint>()
        
        if needsAlign && itemsToBeAligned.endIndex > 1 {
            let attributes = _attributes(forOptions: options)
            
            for index in 0..<(itemsToBeAligned.endIndex - 1) {
                let item1 = itemsToBeAligned[index]
                let item2 = itemsToBeAligned[index + 1]
                
                for eachAttribute in attributes {
                    let anchor1 = item1._ctvfl_anchor(for: eachAttribute)
                    let anchor2 = item2._ctvfl_anchor(for: eachAttribute)
                    
                    let constraint = anchor1._ctvfl_constraint(
                        with: .equal,
                        to: anchor2,
                        constant: 0
                    )
                    
                    alignmentConstraints.append(constraint)
                }
            }
        }
        
        return constraints.map({$0.constraint}) + alignmentConstraints
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

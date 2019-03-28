//
//  CTVFLSyntaxEvaluatable.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol CTVFLSyntaxEvaluatable: CTVFLOpcodeGenerating {
    func makeConstraints(orientation: CTVFLOrientation, options: CTVFLOptions) -> [CTVFLConstraint]
}

internal struct _CTVFLSyntaxEvaluationStackLevel {
    var firstItem: CTVFLItem? = nil
    var firstAttribute: CTVFLLayoutAttribute? = nil
    var secondItem: CTVFLItem? = nil
    var secondAttribute: CTVFLLayoutAttribute? = nil
    var relation: CTVFLLayoutRelation? = nil
    var constant: CTVFLConstant? = nil
    var usesSystemSpace: Bool = false
    var priority: CTVFLPriority = .required
    var evaluationSite: CTVFLOpcode.EvaluationSite = .firstItem
    var retVal: CTVFLItem? = nil
}

extension CTVFLSyntaxEvaluatable {
    public func makeConstraints(orientation: CTVFLOrientation, options: CTVFLOptions) -> [CTVFLConstraint] {
        var stack: ContiguousArray<_CTVFLSyntaxEvaluationStackLevel> = [.init()]
        stack.reserveCapacity(10)
        
        var constraints = ContiguousArray<CTVFLConstraint>()
        constraints.reserveCapacity(10)
        
        var itemsToBeAligned = ContiguousArray<CTVFLLayoutAnchorSelectable>()
        itemsToBeAligned.reserveCapacity(10)
        
        let needsAlign = !options.intersection(.alignmentMask).isEmpty
        
        var opcodes = ContiguousArray<CTVFLOpcode>()
        
        generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &opcodes)
        
        for index in 0..<opcodes.endIndex {
            let eachOpcode = opcodes[index]
            let currentLevel = stack.endIndex - 1
            
            switch eachOpcode {
            case .push:
                stack.append(.init())
            case .pop:
                let topLevel = stack.popLast()!
                let retVal = topLevel.retVal
                let previousLevel = stack.endIndex - 1
                switch stack[previousLevel].evaluationSite {
                case .firstItem:
                    stack[previousLevel].firstItem = retVal
                case .secondItem:
                    stack[previousLevel].secondItem = retVal
                }
                
            case let .moveItem(item):
                if needsAlign {
                    switch item {
                    case let .layoutable(layoutable):
                        itemsToBeAligned.append(layoutable._asAnchorSelector)
                    default: break
                    }
                }
                
                if stack[currentLevel].firstItem == nil {
                    stack[currentLevel].firstItem = item
                } else if stack[currentLevel].secondItem == nil {
                    stack[currentLevel].secondItem = item
                } else {
                    NSException(
                        name: .internalInconsistencyException,
                        reason: "Items overflow.",
                        userInfo: nil
                        ).raise()
                }
            case let .moveAttribute(attr):
                if stack[currentLevel].firstAttribute == nil {
                    stack[currentLevel].firstAttribute = attr
                } else if stack[currentLevel].secondAttribute == nil {
                    stack[currentLevel].secondAttribute = attr
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
            case let .moveUsesSystemSpace(flag):
                stack[currentLevel].usesSystemSpace = flag
            case let .movePriority(value):
                stack[currentLevel].priority = value
            case let .moveReturnValue(retVal):
                switch retVal {
                case .firstItem:
                    stack[currentLevel].retVal = stack[currentLevel].firstItem
                case .secondItem:
                    stack[currentLevel].retVal = stack[currentLevel].secondItem
                }
            case let .moveEvaluationSite(evaluationSite):
                stack[currentLevel].evaluationSite = evaluationSite
            case .makeConstraint:
                let topLevel = stack[currentLevel]
                
                let (
                    firstItem,
                    firstAttribute,
                    secondItem,
                    secondAttribute,
                    relation,
                    constant,
                    usesSystemSpace,
                    priority
                ) = (
                    topLevel.firstItem,
                    topLevel.firstAttribute,
                    topLevel.secondItem,
                    topLevel.secondAttribute,
                    topLevel.relation,
                    topLevel.constant,
                    topLevel.usesSystemSpace,
                    topLevel.priority
                )
                
                let firstSelector = firstItem?._getAnchorSelector(with: secondItem)
                
                let secondSelector = secondItem?._getAnchorSelector(with: firstItem)
                
                switch (firstSelector, firstAttribute, secondSelector, secondAttribute, relation, constant, usesSystemSpace) {
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), .none, true):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    
                    #if os(macOS)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: 8)
                    constraint.priority = priority
                    constraints.append(constraint)
                    #endif
                    
                    #if os(iOS) || os(tvOS)
                    if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                        let constraint = anchor1._ctvfl_constraintUsingSystemSpacing(with: rel, to: anchor2)
                        constraint.priority = priority
                        constraints.append((constraint, sel1, sel2))
                    } else {
                        let anchor1 = sel1._ctvfl_anchor(for: attr1)
                        let anchor2 = sel2._ctvfl_anchor(for: attr2)
                        let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: 8)
                        constraint.priority = priority
                        constraints.append((constraint, sel1, sel2))
                    }
                    #endif
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), .none, false):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2)
                    constraint.priority = priority
                    constraints.append(constraint)
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), .some(c), false):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: CGFloat(c.rawValue))
                    constraint.priority = priority
                    constraints.append(constraint)
                case let (.some(sel), .some(attr), .none, .none, .some(rel), .some(c), false):
                    let anchor = sel._ctvfl_anchor(for: attr)
                    let constraint = anchor._ctvfl_constraint(with: rel, toConstant: CGFloat(c.rawValue))
                    constraint.priority = priority
                    constraints.append(constraint)
                default:
                    debugPrint("Invalid input: First Item = \(firstItem.map({"\($0)"}) ?? "nil"); First Attribute = \(firstAttribute.map({"\($0)"}) ?? "nil"); Second Item = \(secondItem.map({"\($0)"}) ?? "nil"); Second Attribute = \(secondAttribute.map({"\($0)"}) ?? "nil"); Relation = \(relation.map({"\($0)"}) ?? "nil"); Constant = \(constant.map({"\($0)"}) ?? "nil")");
                }
            }
        }
        
        if needsAlign && itemsToBeAligned.endIndex > 1 {
            let attributes = _attributes(forOptions: options)
            
            for index in 0..<(itemsToBeAligned.endIndex - 1) {
                let firstItem = itemsToBeAligned[index]
                let secondItem = itemsToBeAligned[index + 1]
                
                for eachAttribute in attributes {
                    let anchor1 = firstItem._ctvfl_anchor(for: eachAttribute)
                    let anchor2 = secondItem._ctvfl_anchor(for: eachAttribute)
                    
                    let constraint = anchor1._ctvfl_constraint(
                        with: .equal,
                        to: anchor2,
                        constant: 0
                    )
                    
                    constraints.append(constraint)
                }
            }
        }
        
        return constraints.map({$0})
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

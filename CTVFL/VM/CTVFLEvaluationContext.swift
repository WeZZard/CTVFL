//
//  CTVFLEvaluationContext.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

import Dispatch

public class CTVFLEvaluationContext {
    internal static let _sharedQueue = DispatchQueue(label: "com.WeZZard.CTVFL.CTVFLEvaluationContext.SharedQueue", qos: .userInteractive)
    
    internal let _internalQueue = DispatchQueue(label: "com.WeZZard.CTVFL.CTVFLEvaluationContext.InstanceQueue", qos: .userInteractive, target: _sharedQueue)
    
    internal var _stack: ContiguousArray<_CTVFLEvaluationStackLevel>
    
    internal var _constraints: ContiguousArray<CTVFLConstraint>
    
    internal var _itemsToBeAligned: ContiguousArray<CTVFLLayoutAnchorSelectable>
    
    internal var _opcodes: ContiguousArray<CTVFLOpcode>
    
    public init() {
        _stack = [.init()]
        _stack.reserveCapacity(10)
        _constraints = []
        _constraints.reserveCapacity(10)
        _itemsToBeAligned = []
        _itemsToBeAligned.reserveCapacity(10)
        _opcodes = []
    }
    
    internal func _prepareForReuse() {
        _stack.removeAll(keepingCapacity: true)
        _constraints.removeAll(keepingCapacity: true)
        _itemsToBeAligned.removeAll(keepingCapacity: true)
        _opcodes.removeAll(keepingCapacity: true)
    }
    
    public func makeConstraint(
        withSyntax syntax: CTVFLAnySyntax,
        forOrientation orientation: CTVFLOrientation,
        withOptions options: CTVFLOptions
        ) -> [CTVFLConstraint]
    {
        return _internalQueue.sync {
            _prepareForReuse()
            
            let needsAlign = !options.intersection(.alignmentMask).isEmpty
            
            syntax.generateOpcodes(
                forOrientation: orientation,
                withOptions: options,
                withStorage: &_opcodes
            )
            
            for index in 0..<_opcodes.endIndex {
                let eachOpcode = _opcodes[index]
                let currentLevel = _stack.endIndex - 1
                
                switch eachOpcode {
                case .push:
                    _stack.append(.init())
                case .pop:
                    let topLevel = _stack.popLast()!
                    let retVal = topLevel.retVal
                    let previousLevel = _stack.endIndex - 1
                    switch _stack[previousLevel].evaluationSite {
                    case .firstItem:
                        _stack[previousLevel].firstItem = retVal
                    case .secondItem:
                        _stack[previousLevel].secondItem = retVal
                    }
                    
                case let .moveItem(item):
                    if needsAlign {
                        switch item {
                        case let .layoutable(layoutable):
                            _itemsToBeAligned.append(layoutable._asAnchorSelector)
                        default: break
                        }
                    }
                    
                    if _stack[currentLevel].firstItem == nil {
                        _stack[currentLevel].firstItem = item
                    } else if _stack[currentLevel].secondItem == nil {
                        _stack[currentLevel].secondItem = item
                    } else {
                        NSException(
                            name: .internalInconsistencyException,
                            reason: "Items overflow.",
                            userInfo: nil
                            ).raise()
                    }
                case let .moveAttribute(attr):
                    if _stack[currentLevel].firstAttribute == nil {
                        _stack[currentLevel].firstAttribute = attr
                    } else if _stack[currentLevel].secondAttribute == nil {
                        _stack[currentLevel].secondAttribute = attr
                    } else {
                        NSException(
                            name: .internalInconsistencyException,
                            reason: "Attributes overflow.",
                            userInfo: nil
                            ).raise()
                    }
                case let .moveRelation(rel):
                    _stack[currentLevel].relation = rel
                case let .moveConstant(value):
                    _stack[currentLevel].constant = value
                case let .moveUsesSystemSpace(flag):
                    _stack[currentLevel].usesSystemSpace = flag
                case let .movePriority(value):
                    _stack[currentLevel].priority = value
                case let .moveReturnValue(retVal):
                    switch retVal {
                    case .firstItem:
                        _stack[currentLevel].retVal = _stack[currentLevel].firstItem
                    case .secondItem:
                        _stack[currentLevel].retVal = _stack[currentLevel].secondItem
                    }
                case let .moveEvaluationSite(evaluationSite):
                    _stack[currentLevel].evaluationSite = evaluationSite
                case .makeConstraint:
                    let topLevel = _stack[currentLevel]
                    
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
                            _constraints.append((constraint))
                        } else {
                            let anchor1 = sel1._ctvfl_anchor(for: attr1)
                            let anchor2 = sel2._ctvfl_anchor(for: attr2)
                            let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: 8)
                            constraint.priority = priority
                            _constraints.append((constraint))
                        }
                        #endif
                        
                    case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), .none, false):
                        let anchor1 = sel1._ctvfl_anchor(for: attr1)
                        let anchor2 = sel2._ctvfl_anchor(for: attr2)
                        let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2)
                        constraint.priority = priority
                        _constraints.append(constraint)
                    case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), .some(c), false):
                        let anchor1 = sel1._ctvfl_anchor(for: attr1)
                        let anchor2 = sel2._ctvfl_anchor(for: attr2)
                        let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: CGFloat(c.rawValue))
                        constraint.priority = priority
                        _constraints.append(constraint)
                    case let (.some(sel), .some(attr), .none, .none, .some(rel), .some(c), false):
                        let anchor = sel._ctvfl_anchor(for: attr)
                        let constraint = anchor._ctvfl_constraint(with: rel, toConstant: CGFloat(c.rawValue))
                        constraint.priority = priority
                        _constraints.append(constraint)
                    default:
                        debugPrint("Invalid input: First Item = \(firstItem.map({"\($0)"}) ?? "nil"); First Attribute = \(firstAttribute.map({"\($0)"}) ?? "nil"); Second Item = \(secondItem.map({"\($0)"}) ?? "nil"); Second Attribute = \(secondAttribute.map({"\($0)"}) ?? "nil"); Relation = \(relation.map({"\($0)"}) ?? "nil"); Constant = \(constant.map({"\($0)"}) ?? "nil")");
                    }
                }
            }
            
            if needsAlign && _itemsToBeAligned.endIndex > 1 {
                let attributes = _attributes(forOptions: options)
                
                for index in 0..<(_itemsToBeAligned.endIndex - 1) {
                    let firstItem = _itemsToBeAligned[index]
                    let secondItem = _itemsToBeAligned[index + 1]
                    
                    for eachAttribute in attributes {
                        let anchor1 = firstItem._ctvfl_anchor(for: eachAttribute)
                        let anchor2 = secondItem._ctvfl_anchor(for: eachAttribute)
                        
                        let constraint = anchor1._ctvfl_constraint(
                            with: .equal,
                            to: anchor2,
                            constant: 0
                        )
                        
                        _constraints.append(constraint)
                    }
                }
            }
            
            return _constraints.map({$0})
        }
    }
    
    internal func _attributes(forOptions options: CTVFLOptions)
        -> [CTVFLLayoutAttribute]
    {
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
        
        if #available(macOSApplicationExtension 10.11, *) {
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

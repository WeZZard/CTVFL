//
//  CTVFLEvaluationContext.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

import Foundation

@objc
public class CTVFLEvaluationContext: NSObject {
    internal var _evaluationStack: _CTVFLEvaluationStack
    
    internal var _constraints: ContiguousArray<CTVFLConstraint>
    
    internal var _itemsToBeAligned: ContiguousArray<CTVFLLayoutAnchorSelectable>
    
    internal var _opcodes: ContiguousArray<CTVFLOpcode>
    
    internal var _constriantsCount: Int
    
    internal var _itemsToBeAlignedCount: Int
    
    internal var _opcodesCount: Int
    
    @objc
    public override init() {
        _evaluationStack = .init()
        
        _constraints = []
        _constraints.reserveCapacity(10)
        _constriantsCount = 0
        
        _itemsToBeAligned = []
        _itemsToBeAligned.reserveCapacity(10)
        _itemsToBeAlignedCount = 0
        
        _opcodes = []
        _opcodes.reserveCapacity(100)
        _opcodesCount = 0
    }
    
    @objc
    public func evict() {
        // Since `CTVFLLayoutable` and `CTVFLConfinable` stored in the
        // evaluation stack only hold an `unowned(unsafe)` relation to
        // the underlying view and layout guide objects, we dont' have
        // to clean to evaluation stack here.
        _itemsToBeAligned.removeAll(keepingCapacity: true)
        _itemsToBeAlignedCount = 0
        _constraints.removeAll(keepingCapacity: true)
        _constriantsCount = 0
    }
    
    internal func _ensureOpcodesTailElements(_ addition: Int) {
        let targetCount = Swift.max(100, _opcodesCount + addition)
        if _opcodes.capacity < targetCount {
            _opcodes.reserveCapacity(targetCount)
        }
    }
    
    internal func _appendOpcode(_ opcode: CTVFLOpcode) {
        let index = _opcodesCount
        if index == _opcodes.endIndex {
            _opcodes.append(opcode)
        } else if index < _opcodes.endIndex {
            _opcodes[index] = opcode
        } else {
            preconditionFailure()
        }
        _opcodesCount += 1
    }
    
    internal func _appendConstraint(_ constraint: CTVFLConstraint) {
        let index = _constriantsCount
        if index == _constraints.endIndex {
            _constraints.append(constraint)
        } else if index < _constraints.endIndex {
            _constraints[index] = constraint
        } else {
            preconditionFailure()
        }
        _constriantsCount += 1
    }
    
    internal func _appendItemToBeAligned(_ itemToBeAligned: CTVFLLayoutAnchorSelectable) {
        let index = _itemsToBeAlignedCount
        if index == _itemsToBeAligned.endIndex {
            _itemsToBeAligned.append(itemToBeAligned)
        } else if index < _itemsToBeAligned.endIndex {
            _itemsToBeAligned[index] = itemToBeAligned
        } else {
            preconditionFailure()
        }
        _itemsToBeAlignedCount += 1
    }
    
    @nonobjc
    internal func _prepareForReuse() {
        _constriantsCount = 0
        _itemsToBeAlignedCount = 0
        _opcodesCount = 0
    }
    
    @nonobjc
    public func makeConstraint(
        withSyntax syntax: CTVFLAnySyntax,
        forOrientation orientation: CTVFLOrientation,
        withOptions options: CTVFLFormatOptions
        ) -> [CTVFLConstraint]
    {
        _prepareForReuse()
        
        let needsAlign = !options.intersection(.alignmentMask).isEmpty
        
        syntax.generateOpcodes(
            forOrientation: orientation,
            withOptions: options,
            withContext: self
        )
        
        var retVal = _CTVFLEvaluationStackLevel()
        
        _evaluationStack.push()
        
        for index in 0..<_opcodesCount {
            let eachOpcode = _opcodes[index]
            
            switch eachOpcode {
            case .push:
                _evaluationStack.push()
            case .pop:
                retVal = _evaluationStack.pop()
            case let .moveFirstItem(item):
                if needsAlign {
                    switch item {
                    case let .layoutable(layoutable):
                        _appendItemToBeAligned(layoutable._asAnchorSelector)
                    default: break
                    }
                }
                
                _evaluationStack.modifyTopLevel { (level) in
                    level.firstItem = item
                }
            case let .moveFirstItemFromRetVal(site):
                _evaluationStack.modifyTopLevel { (level) in
                    switch site {
                    case .first:
                        level.firstItem = retVal.firstItem
                    case .second:
                        level.firstItem = retVal.secondItem
                    }
                }
            case let .moveSecondItem(item):
                if needsAlign {
                    switch item {
                    case let .layoutable(layoutable):
                        _appendItemToBeAligned(layoutable._asAnchorSelector)
                    default: break
                    }
                }
                
                _evaluationStack.modifyTopLevel { (level) in
                    level.secondItem = item
                }
            case let .moveSecondItemFromRetVal(site):
                _evaluationStack.modifyTopLevel { (level) in
                    switch site {
                    case .first:
                        level.secondItem = retVal.firstItem
                    case .second:
                        level.secondItem = retVal.secondItem
                    }
                }
            case let .moveFirstAttribute(attr):
                _evaluationStack.modifyTopLevel { (level) in
                    level.firstAttribute = attr
                }
            case let .moveFirstAttributeFromRetVal(site):
                _evaluationStack.modifyTopLevel { (level) in
                    switch (site) {
                    case .first:
                        level.firstAttribute = retVal.firstAttribute
                    case .second:
                        level.firstAttribute = retVal.secondAttribute
                    }
                }
            case let .moveSecondAttribute(attr):
                _evaluationStack.modifyTopLevel { (level) in
                    level.secondAttribute = attr
                }
            case let .moveSecondAttributeFromRetVal(site):
                _evaluationStack.modifyTopLevel { (level) in
                    switch (site) {
                    case .first:
                        level.secondAttribute = retVal.firstAttribute
                    case .second:
                        level.secondAttribute = retVal.secondAttribute
                    }
                }
            case let .moveRelation(rel):
                _evaluationStack.modifyTopLevel { (topLevel) in
                    topLevel.relation = rel
                }
            case .moveReleationFromRetVal:
                _evaluationStack.modifyTopLevel { (level) in
                    level.relation = retVal.relation
                }
            case let .moveConstant(value):
                _evaluationStack.modifyTopLevel { (topLevel) in
                    topLevel.constant = value
                }
            case .moveConstantFromRetVal:
                _evaluationStack.modifyTopLevel { (level) in
                    level.constant = retVal.constant
                }
            case let .moveUsesSystemSpace(flag):
                _evaluationStack.modifyTopLevel { (topLevel) in
                    topLevel.usesSystemSpace = flag
                }
            case let .movePriority(value):
                _evaluationStack.modifyTopLevel { (topLevel) in
                    topLevel.priority = value
                }
            case .movePriorityFromRetVal:
                _evaluationStack.modifyTopLevel { (level) in
                    level.priority = retVal.priority
                }
            case .makeConstraint:
                let topLevel = _evaluationStack.peek()
                
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
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), 0, true):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    
                    #if os(macOS)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: 8)
                    constraint.priority = priority
                    _appendConstraint(constraint)
                    #endif
                    
                    #if os(iOS) || os(tvOS)
                    if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                        let constraint = anchor1._ctvfl_constraintUsingSystemSpacing(with: rel, to: anchor2)
                        constraint.priority = priority
                        _appendConstraint(constraint)
                    } else {
                        let anchor1 = sel1._ctvfl_anchor(for: attr1)
                        let anchor2 = sel2._ctvfl_anchor(for: attr2)
                        let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: 8)
                        constraint.priority = priority
                        _appendConstraint(constraint)
                    }
                    #endif
                    
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), 0, false):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2)
                    constraint.priority = priority
                    _appendConstraint(constraint)
                    
                case let (.some(sel1), .some(attr1), .some(sel2), .some(attr2), .some(rel), constant, false):
                    let anchor1 = sel1._ctvfl_anchor(for: attr1)
                    let anchor2 = sel2._ctvfl_anchor(for: attr2)
                    let constraint = anchor1._ctvfl_constraint(with: rel, to: anchor2, constant: constant)
                    constraint.priority = priority
                    _appendConstraint(constraint)
                    
                case let (.some(sel), .some(attr), .none, .none, .some(rel), constant, false):
                    let anchor = sel._ctvfl_anchor(for: attr)
                    let constraint = anchor._ctvfl_constraint(with: rel, toConstant: constant)
                    constraint.priority = priority
                    _appendConstraint(constraint)
                    
                default:
                    debugPrint("Invalid input: First Item = \(firstItem.map({"\($0)"}) ?? "nil"); First Attribute = \(firstAttribute.map({"\($0)"}) ?? "nil"); Second Item = \(secondItem.map({"\($0)"}) ?? "nil"); Second Attribute = \(secondAttribute.map({"\($0)"}) ?? "nil"); Relation = \(relation.map({"\($0)"}) ?? "nil"); Constant = \(constant)");
                }
            }
        }
        
        _ = _evaluationStack.pop()
        
        if needsAlign && _itemsToBeAlignedCount > 1 {
            let attributes = options._attributes
            
            for index in 0..<(_itemsToBeAlignedCount - 1) {
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
                    
                    _appendConstraint(constraint)
                }
            }
        }
        
        var constratins = [CTVFLConstraint]()
        constratins.reserveCapacity(_constriantsCount)
        constratins.append(contentsOf: _constraints[0..<_constriantsCount])
        
        return constratins
    }
}


extension CTVFLFormatOptions {
    internal var _attributes: [CTVFLLayoutAttribute] {
        var attributes = [CTVFLLayoutAttribute]()
        
        if contains(.alignAllBottom) {
            attributes.append(.bottom)
        }
        
        if contains(.alignAllTop) {
            attributes.append(.top)
        }
        
        if contains(.alignAllLeft) {
            attributes.append(.left)
        }
        
        if contains(.alignAllRight) {
            attributes.append(.right)
        }
        
        if contains(.alignAllCenterX) {
            attributes.append(.centerX)
        }
        
        if contains(.alignAllCenterY) {
            attributes.append(.centerY)
        }
        
        if contains(.alignAllLeading) {
            attributes.append(.leading)
        }
        
        if contains(.alignAllTrailing) {
            attributes.append(.trailing)
        }
        
        if #available(macOSApplicationExtension 10.11, *) {
            if contains(.alignAllFirstBaseline) {
                attributes.append(.firstBaseline)
            }
        }
        
        if contains(.alignAllLastBaseline) {
            attributes.append(.lastBaseline)
        }
        
        return attributes
    }
}

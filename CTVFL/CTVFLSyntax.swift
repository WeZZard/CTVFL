//
//  CTVFLSyntax.swift
//  CTVFL
//
//  Created on 2019/3/26.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// `view - view`
///
public struct CTVFLLayoutableToLayoutableSpaceSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand, _CTVFLBinarySyntax where
    Lhs.SyntaxEnd == CTVFLSyntaxEndWithLayoutable,
    Rhs.SyntaxEnd == CTVFLSyntaxEndWithLayoutable,
    Lhs.SyntaxTermination == CTVFLSyntaxIsNotTerminated
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithLayoutable
    public typealias SyntaxTermination = Rhs.SyntaxTermination
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(2)
        storage.append(.push)
        storage.append(.moveAttribute(_lhsAttribute(forOrientation: orientation, withOptions: options)))
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(5)
        storage.append(.moveAttribute(_rhsAttribute(forOrientation: orientation, withOptions: options)))
        storage.append(.moveRelation(.equal))
        storage.append(.moveConstant(CTVFLConstant(rawValue: 8)))
        storage.append(.pop)
        storage.append(.loadRhsItem)
    }
}

/// `n - view`
///
public struct CTVFLConstantToLayoutableSpaceSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand, _CTVFLBinarySyntax where
    Lhs.SyntaxEnd == CTVFLSyntaxEndWithConstant,
    Rhs.SyntaxEnd == CTVFLSyntaxEndWithLayoutable,
    Lhs.SyntaxTermination == CTVFLSyntaxIsNotTerminated
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithLayoutable
    public typealias SyntaxTermination = Rhs.SyntaxTermination
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(2)
        storage.append(.moveAttribute(_rhsAttribute(forOrientation: orientation, withOptions: options)))
        storage.append(.pop)
    }
}

/// `view - n`
///
public struct CTVFLLayoutableToConstantSpaceSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand, _CTVFLBinarySyntax where
    Lhs.SyntaxEnd == CTVFLSyntaxEndWithLayoutable,
    Rhs.SyntaxEnd == CTVFLSyntaxEndWithConstant,
    Lhs.SyntaxTermination == CTVFLSyntaxIsNotTerminated
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithConstant
    public typealias SyntaxTermination = Rhs.SyntaxTermination
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(2)
        storage.append(.push)
        storage.append(.moveAttribute(_lhsAttribute(forOrientation: orientation, withOptions: options)))
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
    }
}

/// `view1 | view2`
///
public struct CTVFLAdjacentSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand, _CTVFLBinarySyntax where
    Lhs.SyntaxEnd == CTVFLSyntaxEndWithLayoutable,
    Rhs.SyntaxEnd == CTVFLSyntaxEndWithLayoutable,
    Lhs.SyntaxTermination == CTVFLSyntaxIsNotTerminated
{
    public typealias LhsOperand = Lhs
    public typealias RhsOperand = Rhs
    
    public typealias LeadingLayoutBoundary = Lhs.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = Rhs.TrailingLayoutBoundary
    public typealias SyntaxEnd = Rhs.SyntaxEnd
    public typealias SyntaxTermination = Rhs.SyntaxTermination
    
    public let lhs: Lhs
    public let rhs: Rhs
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(2)
        storage.append(.push)
        storage.append(.moveAttribute(_lhsAttribute(forOrientation: orientation, withOptions: options)))
        lhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        rhs.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(5)
        storage.append(.moveAttribute(_rhsAttribute(forOrientation: orientation, withOptions: options)))
        storage.append(.moveRelation(.equal))
        storage.append(.moveConstant(CTVFLConstant(rawValue: 0)))
        storage.append(.pop)
        storage.append(.loadRhsItem)
    }
}

/// `|-view`
///
public struct CTVFLSpacedLeadingLayoutableSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand, _CTVFLLeadingSyntax where
    O.SyntaxEnd == CTVFLSyntaxEndWithLayoutable
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(7)
        storage.append(.push)
        storage.append(.moveConstant(CTVFLConstant(rawValue: 8)))
        storage.append(.moveRelation(.equal))
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(2)
        storage.append(.pop)
        storage.append(.loadRhsItem)
    }
}

/// `view-|`
///
public struct CTVFLSpacedTrailingLayoutableSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand, _CTVFLTrailingSyntax where
    O.SyntaxEnd == CTVFLSyntaxEndWithLayoutable
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsTerminated
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(4)
        storage.append(.push)
        storage.append(.moveConstant(CTVFLConstant(rawValue: 8)))
        storage.append(.moveRelation(.equal))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(4)
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        storage.append(.pop)
        storage.append(.loadLhsItem)
    }
}

/// `|view`
///
public struct CTVFLLeadingLayoutableSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand, _CTVFLLeadingSyntax where
    O.SyntaxEnd == CTVFLSyntaxEndWithLayoutable
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(6)
        storage.append(.push)
        storage.append(.moveConstant(CTVFLConstant(rawValue: 0)))
        storage.append(.moveRelation(.equal))
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(2)
        storage.append(.pop)
        storage.append(.loadRhsItem)
    }
}

/// `view|`
///
public struct CTVFLTrailingLayoutableSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand, _CTVFLTrailingSyntax where
    O.SyntaxEnd == CTVFLSyntaxEndWithLayoutable
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsTerminated
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(3)
        storage.append(.push)
        storage.append(.moveConstant(CTVFLConstant(rawValue: 0)))
        storage.append(.moveRelation(.equal))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(5)
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        storage.append(.pop)
        storage.append(.loadLhsItem)
    }
}

/// `|-n`
///
public struct CTVFLLeadingConstantSyntax<O: CTVFLOperand>: CTVFLOperand, _CTVFLLeadingSyntax where
    O.SyntaxEnd == CTVFLSyntaxEndWithConstant
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        storage._ensureTailElements(3)
        storage.append(.push)
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
    }
}

/// `n-|`
///
public struct CTVFLTrailingConstantSyntax<O: CTVFLOperand>: CTVFLOperand, _CTVFLTrailingSyntax where
    O.SyntaxEnd == CTVFLSyntaxEndWithConstant
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsTerminated
    
    public let operand: Operand
    
    public func generateOpcodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions, withStorage storage: inout ContiguousArray<CTVFLOpcode>) {
        operand.generateOpcodes(forOrientation: orientation, withOptions: options, withStorage: &storage)
        storage._ensureTailElements(3)
        storage.append(.moveItem(.container))
        storage.append(.moveAttribute(_attribute(forOrientation: orientation, withOptions: options)))
        storage.append(.pop)
    }
}

// MARK: -

internal protocol _CTVFLLeadingSyntax: CTVFLOperand {
    func _attribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute
}

extension _CTVFLLeadingSyntax {
    @inline(__always)
    internal func _attribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        let rawOptions = options.rawValue
        
        switch orientation {
        case .horizontal:
            if (rawOptions & rawDirectionLeftToRight) != 0 {
                return .left
            } else if (rawOptions & rawDirectionRightToLeft) != 0 {
                return .right
            } else {
                return .leading
            }
        case .vertical:
            #if os(iOS) || os(tvOS)
            if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                if options.contains(.spacingBaselineToBaseline) {
                    return .firstBaseline
                }
            }
            return .top
            #elseif os(macOS)
            return .top
            #endif
        }
    }
}

internal protocol _CTVFLTrailingSyntax: CTVFLOperand {
    func _attribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute
}

extension _CTVFLTrailingSyntax {
    @inline(__always)
    internal func _attribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        let rawOptions = options.rawValue
        
        switch orientation {
        case .horizontal:
            if (rawOptions & rawDirectionLeftToRight) != 0 {
                return .right
            } else if (rawOptions & rawDirectionRightToLeft) != 0 {
                return .left
            } else {
                return .trailing
            }
        case .vertical:
            #if os(iOS) || os(tvOS)
            if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                if options.contains(.spacingBaselineToBaseline) {
                    return .lastBaseline
                }
            }
            return .bottom
            #elseif os(macOS)
            return .bottom
            #endif
        }
    }
}

internal protocol _CTVFLBinarySyntax: CTVFLOperand {
    func _lhsAttribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute
    func _rhsAttribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute
}

extension _CTVFLBinarySyntax {
    @inline(__always)
    internal func _lhsAttribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        let rawOptions = options.rawValue
        
        switch orientation {
        case .horizontal:
            if (rawOptions & rawDirectionLeftToRight) != 0 {
                return .right
            } else if (rawOptions & rawDirectionRightToLeft) != 0 {
                return .left
            } else {
                return .trailing
            }
        case .vertical:
            #if os(iOS) || os(tvOS)
            if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                if options.contains(.spacingBaselineToBaseline) {
                    return .lastBaseline
                }
            }
            return .bottom
            #elseif os(macOS)
            return .bottom
            #endif
        }
    }
    
    @inline(__always)
    internal func _rhsAttribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        let rawOptions = options.rawValue
        
        switch orientation {
        case .horizontal:
            if (rawOptions & rawDirectionLeftToRight) != 0 {
                return .left
            } else if (rawOptions & rawDirectionRightToLeft) != 0 {
                return .right
            } else {
                return .leading
            }
        case .vertical:
            #if os(iOS) || os(tvOS)
            if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                if options.contains(.spacingBaselineToBaseline) {
                    return .firstBaseline
                }
            }
            return .top
            #elseif os(macOS)
            return .top
            #endif
        }
    }
}

let rawDirectionLeftToRight = CTVFLOptions.directionLeftToRight.rawValue
let rawDirectionRightToLeft = CTVFLOptions.directionRightToLeft.rawValue

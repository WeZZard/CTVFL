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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .push,
                .moveAttribute(_lhsAttribute(forOrientation: orientation, withOptions: options)),
            ],
            lhs.opCodes(forOrientation: orientation, withOptions: options),
            rhs.opCodes(forOrientation: orientation, withOptions: options),
            [
                .moveAttribute(_rhsAttribute(forOrientation: orientation, withOptions: options)),
                .moveRelation(.equal),
                .moveConstant(CTVFLConstant(rawValue: 8)),
                .pop
            ],
        ].flatMap({$0}) + [.loadRhsItem]
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            lhs.opCodes(forOrientation: orientation, withOptions: options),
            rhs.opCodes(forOrientation: orientation, withOptions: options),
            [.moveAttribute(_rhsAttribute(forOrientation: orientation, withOptions: options)), .pop],
        ].flatMap({$0})
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [.push, .moveAttribute(_lhsAttribute(forOrientation: orientation, withOptions: options))],
            lhs.opCodes(forOrientation: orientation, withOptions: options),
            rhs.opCodes(forOrientation: orientation, withOptions: options),
        ].flatMap({$0})
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .push,
                .moveAttribute(_lhsAttribute(forOrientation: orientation, withOptions: options)),
            ],
            lhs.opCodes(forOrientation: orientation, withOptions: options),
            rhs.opCodes(forOrientation: orientation, withOptions: options),
            [
                .moveAttribute(_rhsAttribute(forOrientation: orientation, withOptions: options)),
                .moveRelation(.equal),
                .moveConstant(CTVFLConstant(rawValue: 0)),
                .pop
            ],
        ].flatMap({$0}) + [.loadRhsItem]
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .push,
                .moveConstant(CTVFLConstant(rawValue: 8)),
                .moveRelation(.equal),
                .moveItem(.container),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
            ],
            operand.opCodes(forOrientation: orientation, withOptions: options),
            [
                .pop,
                .loadRhsItem,
            ],
        ].flatMap({$0})
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .push,
                .moveConstant(CTVFLConstant(rawValue: 8)),
                .moveRelation(.equal),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
            ],
            operand.opCodes(forOrientation: orientation, withOptions: options),
            [
                .moveItem(.container),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
                .pop,
                .loadLhsItem,
            ],
        ].flatMap({$0})
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .push,
                .moveConstant(CTVFLConstant(rawValue: 0)),
                .moveRelation(.equal),
                .moveItem(.container),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
            ],
            operand.opCodes(forOrientation: orientation, withOptions: options),
            [
                .pop,
                .loadRhsItem,
            ],
        ].flatMap({$0})
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .push,
                .moveConstant(CTVFLConstant(rawValue: 0)),
                .moveRelation(.equal),
            ],
            operand.opCodes(forOrientation: orientation, withOptions: options),
            [
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
                .moveItem(.container),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
                .pop,
                .loadLhsItem,
            ],
        ].flatMap({$0})
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            [
                .push,
                .moveItem(.container),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options))
            ],
            operand.opCodes(forOrientation: orientation, withOptions: options),
        ].flatMap({$0})
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> [CTVFLOpCode] {
        return [
            operand.opCodes(forOrientation: orientation, withOptions: options),
            [
                .moveItem(.container),
                .moveAttribute(_attribute(forOrientation: orientation, withOptions: options)),
                .pop,
            ],
        ].flatMap({$0})
    }
}

// MARK: -

internal protocol _CTVFLLeadingSyntax: CTVFLOperand {
    func _attribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute
}

extension _CTVFLLeadingSyntax {
    internal func _attribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        switch orientation {
        case .horizontal:
            if options.contains(.directionLeftToRight) {
                return .left
            } else if options.contains(.directionRightToLeft) {
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
    internal func _attribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        switch orientation {
        case .horizontal:
            if options.contains(.directionLeftToRight) {
                return .right
            } else if options.contains(.directionRightToLeft) {
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
    internal func _lhsAttribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        switch orientation {
        case .horizontal:
            if options.contains(.directionLeftToRight) {
                return .right
            } else if options.contains(.directionRightToLeft) {
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
    
    internal func _rhsAttribute(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: CTVFLOptions) -> CTVFLLayoutAttribute {
        switch orientation {
        case .horizontal:
            if options.contains(.directionLeftToRight) {
                return .left
            } else if options.contains(.directionRightToLeft) {
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

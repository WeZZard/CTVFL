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

public struct CTVFLLayoutableToLayoutableSpaceSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand where
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        return [
            lhs.opCodes(forOrientation: orientation, withOptions: options),
            [.storeItem, .pop],
            lhs.opCodes(forOrientation: orientation, withOptions: options),
            [.storeItem, .pop],
            [
                .loadItem,
                .loadItem,
                .pushAttribute(.trailing),
                .pushRelation(.equal),
            ],
        ].flatMap({$0})
    }
}

public struct CTVFLConstantToLayoutableSpaceSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand where
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLLayoutableToConstantSpaceSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand where
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLAdjacentSyntax<Lhs: CTVFLOperand, Rhs: CTVFLOperand>:
    CTVFLPopulatableOperand where
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
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLSpacedLeadingSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand {
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public let operand: Operand
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLSpacedTrailingSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand {
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsTerminated
    
    public let operand: Operand
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLLeadingSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand where
    O.SyntaxEnd == CTVFLSyntaxEndWithLayoutable
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = Operand.TrailingLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public let operand: Operand
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLTrailingSyntax<O: CTVFLOperand>: CTVFLPopulatableOperand where
    O.SyntaxEnd == CTVFLSyntaxEndWithLayoutable
{
    public typealias Operand = O
    
    public typealias LeadingLayoutBoundary = Operand.LeadingLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = Operand.SyntaxEnd
    public typealias SyntaxTermination = CTVFLSyntaxIsTerminated
    
    public let operand: Operand
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLLeadingSpaceSyntax: CTVFLOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithConstant
    public typealias SyntaxTermination = CTVFLSyntaxIsNotTerminated
    
    public let operand: CTVFLConstant
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

public struct CTVFLTrailingSpaceSyntax: CTVFLOperand {
    public typealias LeadingLayoutBoundary = CTVFLSyntaxNoLayoutBoundary
    public typealias TrailingLayoutBoundary = CTVFLSyntaxHasLayoutBoundary
    public typealias SyntaxEnd = CTVFLSyntaxEndWithConstant
    public typealias SyntaxTermination = CTVFLSyntaxIsTerminated
    
    public let operand: CTVFLConstant
    
    public func opCodes(forOrientation orientation: CTVFLConstraintOrientation, withOptions options: VFLOptions) -> [CTVFLOpCode] {
        fatalError()
    }
}

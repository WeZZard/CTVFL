//
//  CTVFLLexicon.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

import CoreGraphics

// MARK: - Abstract
// MARK: CTVFLLexiconType
public protocol CTVFLLexiconType {}

public struct CTVFLLexiconConstantType: CTVFLLexiconType {}

public struct CTVFLLexiconVariableType: CTVFLLexiconType {}

// MARK: CTVFLSyntaxState
public protocol CTVFLSyntaxState {}

public struct CTVFLSyntaxNotTerminated: CTVFLSyntaxState {}

public struct CTVFLSyntaxTerminated: CTVFLSyntaxState {}

// MARK: CTVFLLexicon
public protocol CTVFLLexicon {
    associatedtype _FirstLexiconType: CTVFLLexiconType
    
    associatedtype _LastLexiconType: CTVFLLexiconType
    
    associatedtype _SyntaxState: CTVFLSyntaxState
    
    func makePrimitiveVisualFormat(
        with inlineContext: CTVFLInlineContext
        ) -> String
}

internal enum VisualFormatOrientation {
    case vertical
    case horizontal
}

extension CTVFLLexicon {
    internal func _makeVisualFormat(
        with inlineContext: CTVFLInlineContext,
        orientation: VisualFormatOrientation
        ) -> String
    {
        let primitiveVisualFormat = makePrimitiveVisualFormat(with: inlineContext)
        switch orientation {
        case .horizontal:
            return "H:\(primitiveVisualFormat)"
        case .vertical:
            return "V:\(primitiveVisualFormat)"
        }
    }
}

// MARK: CTVFLAdjacentLexicon
public protocol CTVFLAdjacentLexicon: CTVFLLexicon {}

// MARK: CTVFLSpaceableLexicon
public protocol CTVFLSpaceableLexicon: CTVFLLexicon {}

// MARK: - Concrete
// MARK: Lexicons
public struct CTVFLConstantLexicon: CTVFLSpaceableLexicon {
    public typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    public typealias _LastLexiconType = CTVFLLexiconConstantType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    internal let _constant: CTVFLConstant
    
    internal init(constant: CTVFLConstant) {
        _constant = constant
    }
    
    public func makePrimitiveVisualFormat(
        with inlineContext: CTVFLInlineContext
        ) -> String
    {
        return _constant.description
    }
}

public struct CTVFLVariableLexicon: CTVFLSpaceableLexicon,
    CTVFLAdjacentLexicon
{
    internal let _variable: CTVFLVariable
    
    internal init(variable: CTVFLVariable) {
        _variable = variable
    }
    
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    public func makePrimitiveVisualFormat(
        with inlineContext: CTVFLInlineContext
        ) -> String
    {
        let name = inlineContext._name(forVariable: _variable)
        return "[\(name)]"
    }
}

// MARK: Syntaxes
public struct CTVFLLeadingSyntax<L: CTVFLAdjacentLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let lexicon = _lexicon.makePrimitiveVisualFormat(with: inlineContext)
        return "|\(lexicon)"
    }
}

public struct CTVFLTrailingSyntax<L: CTVFLAdjacentLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    public typealias _LastLexiconType = CTVFLLexiconVariableType
    
    public typealias _SyntaxState = CTVFLSyntaxTerminated
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let lexicon = _lexicon.makePrimitiveVisualFormat(with: inlineContext)
        return "\(lexicon)|"
    }
}

public struct CTVFLSpacedLeadingSyntax<L: CTVFLSpaceableLexicon>:
    CTVFLLexicon
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let lexicon = _lexicon.makePrimitiveVisualFormat(with: inlineContext)
        return "|-\(lexicon)"
    }
}

public struct CTVFLSpacedTrailingSyntax<L: CTVFLSpaceableLexicon>:
    CTVFLLexicon
{
    internal typealias _Lexicon = L
    
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = CTVFLSyntaxTerminated
    
    internal let _lexicon: _Lexicon
    
    internal init(lexicon: _Lexicon) {
        _lexicon = lexicon
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let lexicon = _lexicon.makePrimitiveVisualFormat(with: inlineContext)
        return "\(lexicon)-|"
    }
}

public struct CTVFLSpacedSyntax<L1: CTVFLLexicon, L2: CTVFLLexicon>:
    CTVFLLexicon where L1._SyntaxState == CTVFLSyntaxNotTerminated
{
    internal typealias _Lexicon1 = L1
    
    internal typealias _Lexicon2 = L2
    
    public typealias _FirstLexiconType = L1._FirstLexiconType
    
    public typealias _LastLexiconType = L2._LastLexiconType
    
    public typealias _SyntaxState = L2._SyntaxState
    
    internal let _lhs: _Lexicon1
    
    internal let _rhs: _Lexicon2
    
    internal init(lhs: _Lexicon1, rhs: _Lexicon2) {
        _lhs = lhs
        _rhs = rhs
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let lhs = _lhs.makePrimitiveVisualFormat(with: inlineContext)
        let rhs = _rhs.makePrimitiveVisualFormat(with: inlineContext)
        return "\(lhs)-\(rhs)"
    }
}

public struct CTVFLAdjacentSyntax<L1: CTVFLLexicon, L2: CTVFLLexicon>:
    CTVFLLexicon where
    L1._LastLexiconType == CTVFLLexiconVariableType,
    L2._LastLexiconType == CTVFLLexiconVariableType,
    L1._SyntaxState == CTVFLSyntaxNotTerminated
{
    internal typealias _Lexicon1 = L1
    
    internal typealias _Lexicon2 = L2
    
    public typealias _FirstLexiconType = L1._FirstLexiconType
    
    public typealias _LastLexiconType = L2._LastLexiconType
    
    public typealias _SyntaxState = L2._SyntaxState
    
    internal let _lhs: _Lexicon1
    
    internal let _rhs: _Lexicon2
    
    internal init(lhs: _Lexicon1, rhs: _Lexicon2) {
        _lhs = lhs
        _rhs = rhs
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let lhs = _lhs.makePrimitiveVisualFormat(with: inlineContext)
        let rhs = _rhs.makePrimitiveVisualFormat(with: inlineContext)
        return "\(lhs)\(rhs)"
    }
}

public struct CTVFLBracketedVariableSyntax<L: CTVFLAdjacentLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _trailingSyntax: CTVFLTrailingSyntax<L>
    
    internal let _hasLeadingSpacing: Bool
    
    internal init(trailingSyntax: CTVFLTrailingSyntax<L>, hasLeadingSpacing: Bool) {
        _trailingSyntax = trailingSyntax
        _hasLeadingSpacing = hasLeadingSpacing
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let spacing = _hasLeadingSpacing ? "-" : ""
        let trailing = _trailingSyntax.makePrimitiveVisualFormat(with: inlineContext)
        return "|\(spacing)\(trailing)"
    }
}

public struct CTVFLBracketedSpacedVariableSyntax<L: CTVFLSpaceableLexicon>:
    CTVFLLexicon where
    L._FirstLexiconType == CTVFLLexiconVariableType,
    L._LastLexiconType == CTVFLLexiconVariableType
{
    public typealias _FirstLexiconType = L._FirstLexiconType
    
    public typealias _LastLexiconType = L._LastLexiconType
    
    public typealias _SyntaxState = L._SyntaxState
    
    internal let _trailingSyntax: CTVFLSpacedTrailingSyntax<L>
    
    internal let _hasLeadingSpacing: Bool
    
    internal init(trailingSyntax: CTVFLSpacedTrailingSyntax<L>, hasLeadingSpacing: Bool) {
        _trailingSyntax = trailingSyntax
        _hasLeadingSpacing = hasLeadingSpacing
    }
    
    public func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        let spacing = _hasLeadingSpacing ? "-" : ""
        let trailing = _trailingSyntax.makePrimitiveVisualFormat(with: inlineContext)
        return "|\(spacing)\(trailing)"
    }
}

// MARK: - Compositing Syntax
// MARK: Leading Edge
public prefix func | <L>(operand: L) -> CTVFLLeadingSyntax<L> {
    return .init(lexicon: operand)
}

public prefix func | <L: CTVFLVariableConvertible>(operand: L) -> CTVFLLeadingSyntax<CTVFLVariableLexicon> {
    return .init(lexicon: .init(variable: L._makeVariable(operand)))
}

public prefix func | <L>(operand: CTVFLTrailingSyntax<L>) -> CTVFLBracketedVariableSyntax<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: false)
}

public prefix func | <L>(operand: CTVFLSpacedTrailingSyntax<L>) -> CTVFLBracketedSpacedVariableSyntax<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: false)
}

// MARK: Trailing Edge
public postfix func | <L>(operand: L) -> CTVFLTrailingSyntax<L> {
    return .init(lexicon: operand)
}

public postfix func | <L: CTVFLVariableConvertible>(operand: L) -> CTVFLTrailingSyntax<CTVFLVariableLexicon> {
    return .init(lexicon: .init(variable: L._makeVariable(operand)))
}

// MARK: Leading Spaced Edge
public prefix func |- <L>(operand: L) -> CTVFLSpacedLeadingSyntax<L> {
    return .init(lexicon: operand)
}

public prefix func |- <L: CTVFLConstantConvertible>(operand: L) -> CTVFLSpacedLeadingSyntax<CTVFLConstantLexicon> {
    return .init(lexicon: .init(constant: L._makeConstant(operand)))
}

public prefix func |- <L: CTVFLVariableConvertible>(operand: L) -> CTVFLSpacedLeadingSyntax<CTVFLVariableLexicon> {
    return .init(lexicon: .init(variable: L._makeVariable(operand)))
}

public prefix func |- <L>(operand: CTVFLTrailingSyntax<L>) -> CTVFLBracketedVariableSyntax<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: true)
}

public prefix func |- <L>(operand: CTVFLSpacedTrailingSyntax<L>) -> CTVFLBracketedSpacedVariableSyntax<L> {
    return .init(trailingSyntax: operand, hasLeadingSpacing: true)
}

// MARK: Trailing Spaced Edge
public postfix func -| <L>(operand: L) -> CTVFLSpacedTrailingSyntax<L> {
    return .init(lexicon: operand)
}

public postfix func -| <L: CTVFLConstantConvertible>(operand: L) -> CTVFLSpacedTrailingSyntax<CTVFLConstantLexicon> {
    return .init(lexicon: .init(constant: L._makeConstant(operand)))
}

public postfix func -| <L: CTVFLVariableConvertible>(operand: L) -> CTVFLSpacedTrailingSyntax<CTVFLVariableLexicon> {
    return .init(lexicon: .init(variable: L._makeVariable(operand)))
}

// MARK: Spaced Connection
public func - <L1, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, L2> where L1._LastLexiconType == CTVFLLexiconConstantType, L2._FirstLexiconType == CTVFLLexiconVariableType {
    return .init(lhs: lhs, rhs: rhs)
}

public func - <L1, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, L2> where L1._LastLexiconType == CTVFLLexiconVariableType, L2._FirstLexiconType == CTVFLLexiconConstantType {
    return .init(lhs: lhs, rhs: rhs)
}

public func - <L1, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, L2> where L1._LastLexiconType == CTVFLLexiconVariableType, L2._FirstLexiconType == CTVFLLexiconVariableType {
    return .init(lhs: lhs, rhs: rhs)
}

public func - <L1: CTVFLConstantConvertible, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<CTVFLConstantLexicon, L2> where L2._FirstLexiconType == CTVFLLexiconVariableType {
    return .init(lhs: .init(constant: L1._makeConstant(lhs)), rhs: rhs)
}

public func - <L1: CTVFLVariableConvertible, L2>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<CTVFLVariableLexicon, L2> {
    return .init(lhs: .init(variable: L1._makeVariable(lhs)), rhs: rhs)
}

public func - <L1, L2: CTVFLConstantConvertible>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, CTVFLConstantLexicon> where L1._LastLexiconType == CTVFLLexiconVariableType {
    return .init(lhs: lhs, rhs: .init(constant: L2._makeConstant(rhs)))
}

public func - <L1, L2: CTVFLVariableConvertible>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<L1, CTVFLVariableLexicon> {
    return .init(lhs: lhs, rhs: .init(variable: L2._makeVariable(rhs)))
}

public func - <L1: CTVFLConstantConvertible, L2: CTVFLVariableConvertible>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<CTVFLConstantLexicon, CTVFLVariableLexicon> {
    return .init(lhs: .init(constant: L1._makeConstant(lhs)), rhs: .init(variable: L2._makeVariable(rhs)))
}

public func - <L1: CTVFLVariableConvertible, L2: CTVFLConstantConvertible>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<CTVFLVariableLexicon, CTVFLConstantLexicon> {
    return .init(lhs: .init(variable: L1._makeVariable(lhs)), rhs: .init(constant: L2._makeConstant(rhs)))
}

public func - <L1: CTVFLVariableConvertible, L2: CTVFLVariableConvertible>(lhs: L1, rhs: L2) -> CTVFLSpacedSyntax<CTVFLVariableLexicon, CTVFLVariableLexicon> {
    return .init(lhs: .init(variable: L1._makeVariable(lhs)), rhs: .init(variable: L2._makeVariable(rhs)))
}

// MARK: Edge-to-Edge Connection
public func | <L1, L2>(lhs: L1, rhs: L2) -> CTVFLAdjacentSyntax<L1, L2> {
    return .init(lhs: lhs, rhs: rhs)
}

public func | <L1: CTVFLVariableConvertible, L2>(lhs: L1, rhs: L2) -> CTVFLAdjacentSyntax<CTVFLVariableLexicon, L2> {
    return .init(lhs: .init(variable: L1._makeVariable(lhs)), rhs: rhs)
}

public func | <L1, L2: CTVFLVariableConvertible>(lhs: L1, rhs: L2) -> CTVFLAdjacentSyntax<L1, CTVFLVariableLexicon> {
    return .init(lhs: lhs, rhs: .init(variable: L2._makeVariable(rhs)))
}

public func | <L1: CTVFLVariableConvertible, L2: CTVFLVariableConvertible>(lhs: L1, rhs: L2) -> CTVFLAdjacentSyntax<CTVFLVariableLexicon, CTVFLVariableLexicon> {
    return .init(lhs: .init(variable: L1._makeVariable(lhs)), rhs: .init(variable: L2._makeVariable(rhs)))
}

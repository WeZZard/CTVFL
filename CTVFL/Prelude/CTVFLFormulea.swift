//
//  CTVFLFormulea.swift
//  CTVFL
//
//  Created on 2019/3/26.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: Layoutable-to-Layoutable Spacing
public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpaceSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpaceSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSpaceSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpaceSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSpaceSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableSpaceSyntax(lhs: lhs, rhs: rhs)
}

// MARK: Constant-to-Layoutable Spacing
public func - <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSpaceSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLConstantToLayoutableSpaceSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSpaceSyntax<Lhs, Rhs> {
    return CTVFLConstantToLayoutableSpaceSyntax(lhs: lhs, rhs: rhs)
}

// MARK: Layoutable-to-Constant Spacing
public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpaceSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpaceSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpaceSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpaceSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: lhs, rhs: rhs)
}

// MARK: Adjacent
public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLAdjacentSyntax<Lhs, Rhs> {
    return CTVFLAdjacentSyntax(lhs: lhs, rhs: rhs)
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLAdjacentSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLAdjacentSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLAdjacentSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

// MARK: Spaced Leading
public prefix func |- <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLSpacedLeadingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLSpacedLeadingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func |- <Operand>(operand: Operand) -> CTVFLSpacedLeadingLayoutableSyntax<Operand> {
    return CTVFLSpacedLeadingLayoutableSyntax(operand: operand)
}

// MARK: Spaced Trailing
public postfix func -| <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLSpacedTrailingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLSpacedTrailingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func -| <Operand>(operand: Operand) -> CTVFLSpacedTrailingLayoutableSyntax<Operand> {
    return CTVFLSpacedTrailingLayoutableSyntax(operand: operand)
}

// MARK: Leading Space
public prefix func |- <Operand: CTVFLConstantConvertible>(operand: Operand) -> CTVFLLeadingConstantSyntax<CTVFLConstant> {
    return CTVFLLeadingConstantSyntax(operand: Operand._makeConstant(operand))
}

public prefix func |- <Operand>(operand: Operand) -> CTVFLLeadingConstantSyntax<Operand> {
    return CTVFLLeadingConstantSyntax(operand: operand)
}

// MARK: Trailing Space
public postfix func -| <Operand: CTVFLConstantConvertible>(operand: Operand) -> CTVFLTrailingConstantSyntax<CTVFLConstant> {
    return CTVFLTrailingConstantSyntax(operand: Operand._makeConstant(operand))
}

public postfix func -| <Operand>(operand: Operand) -> CTVFLTrailingConstantSyntax<Operand> {
    return CTVFLTrailingConstantSyntax(operand: operand)
}

// MARK: Leading
public prefix func | <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLLeadingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLLeadingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func | <Operand>(operand: Operand) -> CTVFLLeadingLayoutableSyntax<Operand> {
    return CTVFLLeadingLayoutableSyntax(operand: operand)
}

// MARK: Trailing
public postfix func | <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLTrailingLayoutableSyntax<CTVFLLayoutable> {
    return CTVFLTrailingLayoutableSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func | <Operand>(operand: Operand) -> CTVFLTrailingLayoutableSyntax<Operand> {
    return CTVFLTrailingLayoutableSyntax(operand: operand)
}

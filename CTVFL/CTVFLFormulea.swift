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
public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: View, rhs: View) -> CTVFLLayoutableToLayoutableSpaceSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSpaceSyntax(lhs: View._makeLayoutable(lhs), rhs: View._makeLayoutable(rhs))
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
/*
public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpaceSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConstant(rhs))
}
 */

public func - <Lhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: CGFloat) -> CTVFLLayoutableToConstantSpaceSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: CGFloat._makeConstant(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Double) -> CTVFLLayoutableToConstantSpaceSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Double._makeConstant(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Float) -> CTVFLLayoutableToConstantSpaceSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Float._makeConstant(rhs))
}

/*
public func - <Lhs, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSpaceSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}
 */

public func - <Lhs>(lhs: Lhs, rhs: CGFloat) -> CTVFLLayoutableToConstantSpaceSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: lhs, rhs: CGFloat._makeConstant(rhs))
}

public func - <Lhs>(lhs: Lhs, rhs: Double) -> CTVFLLayoutableToConstantSpaceSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: lhs, rhs: Double._makeConstant(rhs))
}

public func - <Lhs>(lhs: Lhs, rhs: Float) -> CTVFLLayoutableToConstantSpaceSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSpaceSyntax(lhs: lhs, rhs: Float._makeConstant(rhs))
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
public prefix func |- <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLSpacedLeadingSyntax<CTVFLLayoutable> {
    return CTVFLSpacedLeadingSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func |- <Operand>(operand: Operand) -> CTVFLSpacedLeadingSyntax<Operand> {
    return CTVFLSpacedLeadingSyntax(operand: operand)
}

// MARK: Spaced Trailing
public postfix func -| <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLSpacedTrailingSyntax<CTVFLLayoutable> {
    return CTVFLSpacedTrailingSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func -| <Operand>(operand: Operand) -> CTVFLSpacedTrailingSyntax<Operand> {
    return CTVFLSpacedTrailingSyntax(operand: operand)
}

// MARK: Leading Space
/*
public prefix func |- <Operand: CTVFLConstantConvertible>(operand: Operand) -> CTVFLLeadingSpaceSyntax {
    return CTVFLLeadingSpaceSyntax(operand: Operand._makeConstant(operand))
}
 */

public prefix func |- (operand: CGFloat) -> CTVFLLeadingSpaceSyntax {
    return CTVFLLeadingSpaceSyntax(operand: CGFloat._makeConstant(operand))
}

public prefix func |- (operand: Double) -> CTVFLLeadingSpaceSyntax {
    return CTVFLLeadingSpaceSyntax(operand: Double._makeConstant(operand))
}

public prefix func |- (operand: Float) -> CTVFLLeadingSpaceSyntax {
    return CTVFLLeadingSpaceSyntax(operand: Float._makeConstant(operand))
}

// MARK: Trailing Space
/*
public postfix func -| <Operand: CTVFLConstantConvertible>(operand: Operand) -> CTVFLTrailingSpaceSyntax {
    return CTVFLTrailingSpaceSyntax(operand: Operand._makeConstant(operand))
}
 */

public postfix func -| (operand: CGFloat) -> CTVFLTrailingSpaceSyntax {
    return CTVFLTrailingSpaceSyntax(operand: CGFloat._makeConstant(operand))
}

public postfix func -| (operand: Double) -> CTVFLTrailingSpaceSyntax {
    return CTVFLTrailingSpaceSyntax(operand: Double._makeConstant(operand))
}

public postfix func -| (operand: Float) -> CTVFLTrailingSpaceSyntax {
    return CTVFLTrailingSpaceSyntax(operand: Float._makeConstant(operand))
}

// MARK: Leading
public prefix func | <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLLeadingSyntax<CTVFLLayoutable> {
    return CTVFLLeadingSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func | <Operand>(operand: Operand) -> CTVFLLeadingSyntax<Operand> {
    return CTVFLLeadingSyntax(operand: operand)
}

// MARK: Trailing
public postfix func | <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLTrailingSyntax<CTVFLLayoutable> {
    return CTVFLTrailingSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func | <Operand>(operand: Operand) -> CTVFLTrailingSyntax<Operand> {
    return CTVFLTrailingSyntax(operand: operand)
}

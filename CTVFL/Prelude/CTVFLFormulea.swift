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
public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSystemSpacingSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSystemSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSystemSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableSystemSpacingSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSystemSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableSystemSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableSystemSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableSystemSpacingSyntax(lhs: lhs, rhs: rhs)
}

// MARK: Constant-to-Layoutable Spacing
public func - <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSystemSpacingSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLConstantToLayoutableSystemSpacingSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLConstantToLayoutableSystemSpacingSyntax<Lhs, Rhs> {
    return CTVFLConstantToLayoutableSystemSpacingSyntax(lhs: lhs, rhs: rhs)
}

// MARK: Layoutable-to-Constant Spacing
public func - <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSystemSpacingSyntax<CTVFLLayoutable, CTVFLConstant> {
    return CTVFLLayoutableToConstantSystemSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs, Rhs: CTVFLConstantConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSystemSpacingSyntax<Lhs, CTVFLConstant> {
    return CTVFLLayoutableToConstantSystemSpacingSyntax(lhs: lhs, rhs: Rhs._makeConstant(rhs))
}

public func - <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSystemSpacingSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToConstantSystemSpacingSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

public func - <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToConstantSystemSpacingSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToConstantSystemSpacingSyntax(lhs: lhs, rhs: rhs)
}

// MARK: Adjacent
public func | <Lhs, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: rhs)
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs, Rhs: CTVFLLayoutableConvertible>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<Lhs, CTVFLLayoutable> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: lhs, rhs: Rhs._makeLayoutable(rhs))
}

public func | <Lhs: CTVFLLayoutableConvertible, Rhs>(lhs: Lhs, rhs: Rhs) -> CTVFLLayoutableToLayoutableAdjacentSyntax<CTVFLLayoutable, Rhs> {
    return CTVFLLayoutableToLayoutableAdjacentSyntax(lhs: Lhs._makeLayoutable(lhs), rhs: rhs)
}

// MARK: Spaced Leading
public prefix func |- <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLLeadingLayoutableWithSystemSpacingSyntax<CTVFLLayoutable> {
    return CTVFLLeadingLayoutableWithSystemSpacingSyntax(operand: Operand._makeLayoutable(operand))
}

public prefix func |- <Operand>(operand: Operand) -> CTVFLLeadingLayoutableWithSystemSpacingSyntax<Operand> {
    return CTVFLLeadingLayoutableWithSystemSpacingSyntax(operand: operand)
}

// MARK: Spaced Trailing
public postfix func -| <Operand: CTVFLLayoutableConvertible>(operand: Operand) -> CTVFLTrailingLayoutableWithSystemSpacingSyntax<CTVFLLayoutable> {
    return CTVFLTrailingLayoutableWithSystemSpacingSyntax(operand: Operand._makeLayoutable(operand))
}

public postfix func -| <Operand>(operand: Operand) -> CTVFLTrailingLayoutableWithSystemSpacingSyntax<Operand> {
    return CTVFLTrailingLayoutableWithSystemSpacingSyntax(operand: operand)
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

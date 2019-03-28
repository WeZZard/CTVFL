//
//  CTVFLLexicon.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - CTVFLOperand
public protocol CTVFLOperand: CTVFLOpcodeGenerating {
    associatedtype LeadingLayoutBoundary: CTVFLSyntaxLayoutBoundary
    associatedtype TrailingLayoutBoundary: CTVFLSyntaxLayoutBoundary
    associatedtype OperableForm: CTVFLSyntaxOperableForm
    associatedtype HeadAssociativity: CTVFLSyntaxAssociativity
    associatedtype TailAssociativity: CTVFLSyntaxAssociativity
}

// MARK: -
// MARK: CTVFLSyntaxOperableForm
public protocol CTVFLSyntaxOperableForm {}

public struct CTVFLSyntaxOperableFormLayoutable: CTVFLSyntaxOperableForm {}

public struct CTVFLSyntaxOperableFormConstant: CTVFLSyntaxOperableForm {}

// MARK: CTVFLSyntaxLayoutBoundary
public protocol CTVFLSyntaxLayoutBoundary {}

public struct CTVFLSyntaxHasLayoutBoundary: CTVFLSyntaxLayoutBoundary {}

public struct CTVFLSyntaxNoLayoutBoundary: CTVFLSyntaxLayoutBoundary {}

// MARK: CTVFLSyntaxAssociativity
public protocol CTVFLSyntaxAssociativity {}

public struct CTVFLSyntaxAssociativityIsOpen: CTVFLSyntaxAssociativity {}

public struct CTVFLSyntaxAssociativityIsClosed: CTVFLSyntaxAssociativity {}

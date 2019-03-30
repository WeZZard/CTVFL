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
public protocol CTVFLOperand: CTVFLAnySyntax {
    associatedtype HeadBoundary: CTVFLSyntaxBoundary
    
    associatedtype TailBoundary: CTVFLSyntaxBoundary
    
    associatedtype HeadAttribute: CTVFLSyntaxAttribute
    
    associatedtype TailAttribute: CTVFLSyntaxAttribute
    
    /// Whether can be associated "as" another syntax's lhs
    associatedtype HeadAssociativity: CTVFLSyntaxAssociativity
    
    /// Whether can be associated "as" another syntax's rhs
    associatedtype TailAssociativity: CTVFLSyntaxAssociativity
}

// MARK: -
// MARK: CTVFLSyntaxBoundary
public protocol CTVFLSyntaxBoundary {}

public struct CTVFLSyntaxBoundaryIsLayoutedObjectOrConfinment: CTVFLSyntaxBoundary {}

public struct CTVFLSyntaxBoundaryIsConstant: CTVFLSyntaxBoundary {}

// MARK: CTVFLSyntaxAttribute
public protocol CTVFLSyntaxAttribute {}

public struct CTVFLSyntaxAttributeLayoutedObject: CTVFLSyntaxAttribute {}

public struct CTVFLSyntaxAttributeConfinment: CTVFLSyntaxAttribute {}

public struct CTVFLSyntaxAttributeConstant: CTVFLSyntaxAttribute {}

// MARK: CTVFLSyntaxAssociativity
public protocol CTVFLSyntaxAssociativity {}

public struct CTVFLSyntaxAssociativityIsOpen: CTVFLSyntaxAssociativity {}

public struct CTVFLSyntaxAssociativityIsClosed: CTVFLSyntaxAssociativity {}

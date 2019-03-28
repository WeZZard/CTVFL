//
//  Utilities.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

// MARK: Type Normalizations
#if os(iOS) || os(tvOS)
import UIKit

public typealias CTVFLView = UIView

public typealias CTVFLPriority = UILayoutPriority

public typealias CTVFLOptions = NSLayoutFormatOptions

public typealias CTVFLLayoutRelation = NSLayoutRelation

@available(iOSApplicationExtension 9.0, tvOSApplicationExtension 9.0, *)
public typealias CTVFLLayoutGuide = UILayoutGuide
#else
import AppKit

public typealias CTVFLView = NSView

public typealias CTVFLPriority = NSLayoutConstraint.Priority

public typealias CTVFLOptions = NSLayoutConstraint.FormatOptions

public typealias CTVFLLayoutRelation = NSLayoutConstraint.Relation

@available(macOSApplicationExtension 10.11, *)
public typealias CTVFLLayoutGuide = NSLayoutGuide
#endif

public typealias CTVFLConstraint = NSLayoutConstraint

// MARK: Assertions & Predictions
internal func _assert(
    _ expression: @autoclosure () -> Bool,
    _ message: String = "",
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line
    )
{
    #if DEBUG
        if !expression() {
            let exception = NSException(
                name: .internalInconsistencyException,
                reason: """
                Asserrtion failure for function \"\(function)\" in file
                \"\(file)\" at line \(line). \(message)
                """,
                userInfo: [:]
            )
            exception.raise()
        }
    #endif
}

internal func _precond(
    _ expression: @autoclosure () -> Bool,
    _ message: String = "",
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line
    )
{
    if !expression() {
        let exception = NSException(
            name: .internalInconsistencyException,
            reason: """
            Precondition failure for function \"\(function)\" in file
            \"\(file)\" at line \(line). \(message)
            """,
            userInfo: [:]
        )
        exception.raise()
    }
}

internal func _precondFailed(
    _ message: String = "",
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line
    ) -> Never
{
    let exception = NSException(
        name: .internalInconsistencyException,
        reason: """
        Precondition failure for function \"\(function)\" in file
        \"\(file)\" at line \(line). \(message)
        """,
        userInfo: [:]
    )
    exception.raise()
    exit(0)
}


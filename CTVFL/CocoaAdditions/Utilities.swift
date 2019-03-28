//
//  Utilities.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//


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


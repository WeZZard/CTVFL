//
//  Utilities.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

// MARK: Type Normalizations
#if os(iOS) || os(tvOS)
    import UIKit
    
    public typealias View = UIView
    
    public typealias Priority = UILayoutPriority
    
    public typealias VFLOptions = NSLayoutFormatOptions
#else
    import AppKit
    
    public typealias View = NSView
    
    public typealias Priority = NSLayoutConstraint.Priority
    
    public typealias VFLOptions = NSLayoutConstraint.FormatOptions
#endif

public typealias Constraint = NSLayoutConstraint

// MARK: Sequence of View
extension Sequence where Element: View {
    internal var _commonAncestor: View? {
        var countForID = [ObjectIdentifier : Int]()
        
        var baseViews = [View]()
        for each in self {
            baseViews.append(each)
        }
        
        let thresholdCount = baseViews.count
        
        var ancestorViews = baseViews.map({$0.superview}).compactMap({$0})
        
        while !ancestorViews.isEmpty {
            let nextAncestor = ancestorViews.removeFirst()
            
            let ancestorID = ObjectIdentifier(nextAncestor)
            
            if var count = countForID[ancestorID] {
                count += 1
                if count < thresholdCount {
                    countForID[ancestorID] = count
                } else {
                    return nextAncestor
                }
            } else {
                if 1 < thresholdCount {
                    countForID[ancestorID] = 1
                } else {
                    return nextAncestor
                }
            }
            
            if let nextAncestor = nextAncestor.superview {
                ancestorViews.append(nextAncestor)
            }
        }
        
        return nil
    }
}

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


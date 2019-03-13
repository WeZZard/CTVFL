//
//  CTVFLPredicatable.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

// MARK: - Predicate
public protocol CTVFLPredicatable {
    func `where`(_ predicates: CTVFLPredicating...)
        -> CTVFLPredicatedVariable
}

extension View: CTVFLPredicatable {
    public func `where`(
        _ predicates: CTVFLPredicating...
        ) -> CTVFLPredicatedVariable
    {
        return .init(variable: .init(self), predicates: predicates)
    }
}

extension View {
    @available(*, deprecated, renamed: "where")
    public func that(
        _ predicates: CTVFLPredicating...
        ) -> CTVFLPredicatedVariable
    {
        return .init(variable: .init(self), predicates: predicates)
    }
}

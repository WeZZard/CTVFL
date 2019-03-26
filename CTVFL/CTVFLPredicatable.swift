//
//  CTVFLPredicatable.swift
//  CTVFL
//
//  Created by WeZZard on 9/19/17.
//

// MARK: - Predicate
public protocol CTVFLPredicatable {
    func `where`(_ predicates: CTVFLPredicating...)
        -> CTVFLPredicatedLayoutable
}

extension View: CTVFLPredicatable {
    public func `where`(
        _ predicates: CTVFLPredicating...
        ) -> CTVFLPredicatedLayoutable
    {
        return .init(layoutable: .init(self), predicates: predicates)
    }
}

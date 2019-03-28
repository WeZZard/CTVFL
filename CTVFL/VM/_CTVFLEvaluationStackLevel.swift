//
//  _CTVFLEvaluationStackLevel.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


internal struct _CTVFLEvaluationStackLevel {
    var firstItem: CTVFLOpcode.Item? = nil
    var firstAttribute: CTVFLLayoutAttribute? = nil
    var secondItem: CTVFLOpcode.Item? = nil
    var secondAttribute: CTVFLLayoutAttribute? = nil
    var relation: CTVFLLayoutRelation? = nil
    var constant: CTVFLConstant? = nil
    var usesSystemSpace: Bool = false
    var priority: CTVFLPriority = .required
    var evaluationSite: CTVFLOpcode.EvaluationSite = .firstItem
    var retVal: CTVFLOpcode.Item? = nil
}

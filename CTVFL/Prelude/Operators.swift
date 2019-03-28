//
//  Operators.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


precedencegroup CTVFLPriorityModifyPrecedence {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: AssignmentPrecedence
}

infix operator ~ : CTVFLPriorityModifyPrecedence

prefix operator <=

prefix operator >=

prefix operator ==

prefix operator |-

postfix operator -|

prefix operator |

postfix operator |

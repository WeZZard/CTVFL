//
//  _CTVFLTrailingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol _CTVFLTrailingSyntax: _CTVFLUnarySyntax where
    Operand.TailAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    
}

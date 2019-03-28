//
//  _CTVFLLeadingSyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol _CTVFLLeadingSyntax: _CTVFLUnarySyntax where
    Operand.HeadAssociativity == CTVFLSyntaxAssociativityIsOpen
{
    
}

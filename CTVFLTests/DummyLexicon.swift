//
//  DummyLexicon.swift
//  CTVFL
//
//  Created by WeZZard Li on 9/21/17.
//

import Foundation

import CTVFL

protocol CTVFLDummyLexicon: CTVFLLexicon {
    var indicator: String { get }
}

extension CTVFLDummyLexicon {
    func makePrimitiveVisualFormat(with inlineContext: CTVFLInlineContext) -> String {
        return indicator
    }
}

struct DummyLexicon: CTVFLDummyLexicon, CTVFLLexicon {
    typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    typealias _LastLexiconType = CTVFLLexiconConstantType
    
    typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    let indicator: String
    
    init(indicator: String = "") { self.indicator = indicator }
    
}

struct DummyVariableLexicon: CTVFLDummyLexicon, CTVFLAdjacentLexicon, CTVFLSpaceableLexicon {
    typealias _FirstLexiconType = CTVFLLexiconVariableType
    
    typealias _LastLexiconType = CTVFLLexiconVariableType
    
    typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    let indicator: String
    
    init(indicator: String = "") { self.indicator = indicator }
}

struct DummyConstantLexicon: CTVFLDummyLexicon, CTVFLSpaceableLexicon {
    typealias _FirstLexiconType = CTVFLLexiconConstantType
    
    typealias _LastLexiconType = CTVFLLexiconConstantType
    
    typealias _SyntaxState = CTVFLSyntaxNotTerminated
    
    let indicator: String
    
    init(indicator: String = "") { self.indicator = indicator }
}

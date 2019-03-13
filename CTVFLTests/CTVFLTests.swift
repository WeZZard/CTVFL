//
//  CTVFLTests.swift
//  CTVFL
//
//  Created by WeZZard on 9/20/17.
//

import XCTest

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

import CTVFL

class CTVFLTests: XCTestCase {
    func testCanCompile() {
        let rootView = View()
        
        let view1 = View()
        let view2 = View()
        
        rootView.addSubview(view1)
        rootView.addSubview(view2)
        
        withVFL(H: view1.where(<=200))
        
        withVFL(H: view1.where(200))
        
        withVFL(H: view1.where(200 ~ 20))
        
        withVFL(H: |view1|)
        
        withVFL(H: |view1-|)
        
        withVFL(H: |-view1|)
        
        withVFL(H: view1 | view2)
        
        withVFL(H: view1.where(==view2))
        
        withVFL(H: view1 - view2)
        
        withVFL(H: view1 - 2 - view2.where(<=2, >=100 ~ 1000))
        
        withVFL(H: |-view1 - 2 - view2.where(<=2, >=100 ~ 1000)-|)
        
        withVFL(H: view1 - (<=200)-|)
    }
    
}

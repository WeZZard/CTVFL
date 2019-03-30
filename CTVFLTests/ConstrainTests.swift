//
//  ConstrainTests.swift
//  CTVFL
//
//  Created on 2019/3/28.
//

import XCTest

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

import CTVFL

class ConstrainTests: XCTestCase {
    var rootView: CTVFLView!
    var view1: CTVFLView!
    var view2: CTVFLView!
    var view3: CTVFLView!
    
    override func setUp() {
        super.setUp()
        rootView = CTVFLView()
        
        view1 = CTVFLView()
        view2 = CTVFLView()
        view3 = CTVFLView()
        
        rootView.addSubview(view1)
        rootView.addSubview(view2)
        rootView.addSubview(view3)
    }
    
    #if os(iOS) || os(tvOS)
    func testConstrain_installsConstraintsAtLocal_withLayoutGuideAndView() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            XCTAssertTrue(rootView.constraints.isEmpty)
            
            constrain {
                withVFL(H: rootView.safeAreaLayoutGuide - view1)
                withVFL(V: rootView.safeAreaLayoutGuide - view1)
            }
            
            XCTAssertFalse(rootView.constraints.isEmpty)
        }
    }
    #endif
    
    func testConstrain_installsConstraintsAtLocal_withHeightAndWidth() {
        XCTAssertTrue(view1.constraints.isEmpty)
        
        constrain {
            withVFL(H: view1.where(200))
            withVFL(V: view1.where(200))
        }
        
        XCTAssertFalse(view1.constraints.isEmpty)
    }
    
    func testConstrain_installsConstraintsToRemote_withEdges() {
        XCTAssertTrue(view1.constraints.isEmpty)
        XCTAssertTrue(rootView.constraints.isEmpty)
        
        constrain {
            withVFL(H: |view1|)
            withVFL(V: |view1|)
        }
        
        XCTAssertTrue(view1.constraints.isEmpty)
        XCTAssertFalse(rootView.constraints.isEmpty)
    }
}

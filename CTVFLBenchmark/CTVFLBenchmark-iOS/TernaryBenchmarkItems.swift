//
//  TernaryBenchmarkItems.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/30.
//

import UIKit
import CTVFL
import Cartography
import SnapKit


let systemSpacedConnectedTripleItems = TernaryBenchmarkItem(
    description: "Three Views with System Spacing",
    vfl: "[view1]-[view2]-[view3]",
    makeCTVFL: { (rootView, view1, view2, view3) in
        withVFL(H: view1 - view2 - view3)
    }
)

let specificSpacedConnectedTripleItems = TernaryBenchmarkItem(
    description: "Three Views with Specific Spacing",
    vfl: "[view1]-10-[view2]-10-[view3]",
    makeCTVFL: { (rootView, view1, view2, view3) in
        let views = view1 - 10 - view2
        withVFL(H: views - 10 - view3)
    },
    makeSnapKit: { (rootView, view1, view2, view3) in
        view1.snp.prepareConstraints { (view1) in
            view1.trailing.equalTo(view2.snp.leading).offset(-10)
        }
        view2.snp.prepareConstraints { (view2) in
            view2.trailing.equalTo(view3.snp.leading).offset(-10)
        }
    },
    makeCartography: { (rootView, view1, view2, view3) in
        constrain(view1, view2, view3) {
            (view1, view2, view3) in
            view1.trailing == view2.leading - 10
            view2.trailing == view3.leading - 10
        }
    }
)

let edgeToEdgeTripleItems = TernaryBenchmarkItem(
    description: "Three Views Edge-to-Edge",
    vfl: "[view1][view2][view3]",
    makeCTVFL: { (rootView, view1, view2, view3) in
        withVFL(H: view1 | view2 | view3)
    },
    makeSnapKit: { (rootView, view1, view2, view3) in
        view1.snp.prepareConstraints { (view1) in
            view1.trailing.equalTo(view2.snp.leading)
        }
        view2.snp.prepareConstraints { (view2) in
            view2.trailing.equalTo(view3.snp.leading)
        }
    },
    makeCartography: { (rootView, view1, view2, view3) in
        constrain(view1, view2, view3) {
            (view1, view2, view3) in
            view1.trailing == view2.leading
            view2.trailing == view3.leading
        }
    }
)

let ternaryBenchmarkItems = [
    systemSpacedConnectedTripleItems,
    specificSpacedConnectedTripleItems,
    edgeToEdgeTripleItems,
]

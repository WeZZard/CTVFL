//
//  BinaryBenchmarkItems.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/30.
//


import UIKit
import CTVFL
import Cartography
import SnapKit

let systemSpacedConnectedItems = BinaryBenchmarkItem(
    description: "Two Views with System Spacing",
    vfl: "[view1]-[view2]",
    makeCTVFL: { (rootView, view1, view2) in withVFL(H: view1 - view2) }
)

let specificSpacedConnectedItems = BinaryBenchmarkItem(
    description: "Two Views with Specific Spacing",
    vfl: "[view1]-10-[view2]",
    makeCTVFL: { (rootView, view1, view2) in withVFL(H: view1 - 10 - view2) },
    makeSnapKit: { (rootView, view1, view2) in
        view1.snp.prepareConstraints { (view1) in
            view1.trailing.equalTo(view2.snp.leading).offset(-10)
        }
    },
    makeCartography: { (rootView, view1, view2) in
        constrain(view1, view2) {
            (view1, view2) in
            view1.trailing == view2.leading - 10
        }
    }
)

let edgeToEdgeItems = BinaryBenchmarkItem(
    description: "Two Views Edge-to-Edge",
    vfl: "[view1][view2]",
    makeCTVFL: { (rootView, view1, view2) in withVFL(H: view1 | view2) },
    makeSnapKit: { (rootView, view1, view2) in
        view1.snp.prepareConstraints { (view1) in
            view1.trailing.equalTo(view2.snp.leading)
        }
    },
    makeCartography: { (rootView, view1, view2) in
        constrain(view1, view2) {
            (view1, view2) in
            view1.trailing == view2.leading
        }
    }
)

let binaryBenchmarkItems = [
    systemSpacedConnectedItems,
    specificSpacedConnectedItems,
    edgeToEdgeItems,
]

//
//  UnaryBenchmarkItems.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/30.
//

import UIKit
import CTVFL
import Cartography
import SnapKit

let widthItem = UnaryBenchmarkItem(
    description: "View's Width",
    vfl: "[view(200)]",
    makeCTVFL: { (rootView, view) in withVFL(H: view.where(200)) },
    makeSnapKit: { (rootView, view) in
        view.snp.prepareConstraints { (view) in
            view.width.equalTo(200)
        }
    },
    makeCartography: { (rootView, view) in
        constrain(view) { (view) in view.width == 200 }
    }
)

let heightItem = UnaryBenchmarkItem(
    description: "View's Height",
    vfl: "V:[view(200)]",
    makeCTVFL: { (rootView, view) in
        withVFL(V: view.where(200))
    },
    makeSnapKit: { (rootView, view) in
        view.snp.prepareConstraints { (view) in
            view.height.equalTo(200)
        }
    },
    makeCartography: { (rootView, view) in
        constrain(view) { (view) in view.height == 200 }
    }
)

let leadingItem = UnaryBenchmarkItem(
    description: "View's Leading to Superview's Leading",
    vfl: "|[view]",
    makeCTVFL: { (rootView, view) in
        withVFL(H: |view)
    },
    makeSnapKit: { (rootView, view) in
        view.snp.prepareConstraints { (view) in
            view.leading.equalTo(rootView.snp.leading)
        }
    },
    makeCartography: { (rootView, view) in
        constrain(rootView, view) { (rootView, view) in
            view.leading == rootView.leading
        }
    }
)

let rightItemWithRightToLeft = UnaryBenchmarkItem(
    description: "View's Right to Superview's Right (with right-to-left direction)",
    vfl: "|[view]",
    formatOptions: .directionRightToLeft,
    makeCTVFL: { (rootView, view) in
        withVFL(H: |view, options: .directionRightToLeft)
    }
)

let leftItemWithRightToLeft = UnaryBenchmarkItem(
    description: "View's Left to Superview's Left (with right-to-left direction)",
    vfl: "[view]|",
    formatOptions: .directionRightToLeft,
    makeCTVFL: { (rootView, view) in
        withVFL(H: view|, options: .directionRightToLeft)
    }
)

let topItem = UnaryBenchmarkItem(
    description: "View's Top to  Superview's Top",
    vfl: "V:|[view]",
    makeCTVFL: { (rootView, view) in
        withVFL(V: |view)
    },
    makeSnapKit: { (rootView, view) in
        view.snp.prepareConstraints { (view) in
            view.top.equalTo(rootView.snp.top)
        }
    },
    makeCartography: { (rootView, view) in
        constrain(rootView, view) { (rootView, view) in
            view.top == rootView.top
        }
    }
)

let systemSpacedLeadingItem = UnaryBenchmarkItem(
    description: "View's Leading to Superview's Leading with System Spacing",
    vfl: "|-[view]",
    makeCTVFL: { (rootView, view) in
        withVFL(H: |-view)
    }
)

let specificSpacedLeadingItem = UnaryBenchmarkItem(
    description: "View's Leading to Superview's Leading with Specific Spacing",
    vfl: "|-10-[view]",
    makeCTVFL: { (rootView, view) in
        withVFL(H: |-10 - view)
    },
    makeSnapKit: { (rootView, view) in
        view.snp.prepareConstraints { (view) in
            view.leading.equalTo(rootView.snp.leading).offset(10)
        }
    },
    makeCartography: { (rootView, view) in
        constrain(rootView, view) { (rootView, view) in
            view.top == rootView.top + 10
        }
    }
)

let unaryBenchmarkItems: [BenchmarkItem] = [
    widthItem,
    heightItem,
    leadingItem,
    topItem,
    rightItemWithRightToLeft,
    leftItemWithRightToLeft,
    systemSpacedLeadingItem,
    specificSpacedLeadingItem,
]

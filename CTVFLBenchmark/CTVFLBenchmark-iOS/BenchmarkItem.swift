//
//  BenchmarkItem.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/27.
//

import UIKit
import CTVFL

class BenchmarkItem {
    let vfl: String
    
    let formatOptions: NSLayoutConstraint.FormatOptions
    
    let description: String
    
    init(description: String, vfl: String, formatOptions: NSLayoutConstraint.FormatOptions) {
        self.description = description
        self.vfl = vfl
        self.formatOptions = formatOptions
    }
}

class UnaryBenchmarkItem: BenchmarkItem {
    typealias Factory = (_ rootView: CTVFLView, _ view: CTVFLView) -> Void
    
    let makeCTVFL: Factory?
    let makeSnapKit: Factory?
    let makeCartography: Factory?
    
    func makeVFL(_ rootView: CTVFLView, _ view: CTVFLView) -> Void {
        NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: nil, views: ["view": view])
    }
    
    init(
        description: String,
        vfl: String,
        formatOptions: NSLayoutConstraint.FormatOptions=[],
        makeCTVFL: Factory?=nil,
        makeSnapKit: Factory?=nil,
        makeCartography: Factory?=nil
        )
    {
        self.makeCTVFL = makeCTVFL
        self.makeSnapKit = makeSnapKit
        self.makeCartography = makeCartography
        super.init(description: description, vfl: vfl, formatOptions: formatOptions)
    }
}

class BinaryBenchmarkItem: BenchmarkItem {
    typealias Factory = (_ rootView: CTVFLView, _ view1: CTVFLView, _ view2: CTVFLView) -> Void
    
    let makeCTVFL: Factory?
    let makeSnapKit: Factory?
    let makeCartography: Factory?
    
    func makeVFL(_ rootView: CTVFLView, _ view1: CTVFLView, _ view2: CTVFLView) -> Void {
        NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: nil, views: ["view1": view1, "view2": view2])
    }
    
    init(
        description: String,
        vfl: String,
        formatOptions: NSLayoutConstraint.FormatOptions=[],
        makeCTVFL: Factory?=nil,
        makeSnapKit: Factory?=nil,
        makeCartography: Factory?=nil
        )
    {
        self.makeCTVFL = makeCTVFL
        self.makeSnapKit = makeSnapKit
        self.makeCartography = makeCartography
        super.init(description: description, vfl: vfl, formatOptions: formatOptions)
    }
}

class TernaryBenchmarkItem: BenchmarkItem {
    typealias Factory = (_ rootView: CTVFLView, _ view1: CTVFLView, _ view2: CTVFLView, _ view3: CTVFLView) ->Void
    
    let makeCTVFL: Factory?
    let makeSnapKit: Factory?
    let makeCartography: Factory?
    
    func makeVFL(_ rootView: CTVFLView, _ view1: CTVFLView, _ view2: CTVFLView, _ view3: CTVFLView) -> Void {
        NSLayoutConstraint.constraints(withVisualFormat: vfl, options: [], metrics: nil, views: ["view1": view1, "view2": view2, "view3": view3])
    }
    
    init(
        description: String,
        vfl: String,
        formatOptions: NSLayoutConstraint.FormatOptions=[],
        makeCTVFL: Factory?=nil,
        makeSnapKit: Factory?=nil,
        makeCartography: Factory?=nil
        )
    {
        self.makeCTVFL = makeCTVFL
        self.makeSnapKit = makeSnapKit
        self.makeCartography = makeCartography
        super.init(description: description, vfl: vfl, formatOptions: formatOptions)
    }
}

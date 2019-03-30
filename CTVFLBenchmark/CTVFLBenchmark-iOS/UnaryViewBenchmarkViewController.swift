//
//  UnaryViewBenchmarkViewController.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/27.
//

import UIKit

class UnaryViewBenchmarkViewController: BenchmarkViewController<UnaryBenchmarkItem> {
    var rootView: UIView!
    var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView = UIView()
        targetView = UIView()
        rootView.addSubview(targetView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        beginMeasure()
        
        measure(.vfl) {
            _ = item.makeVFL(rootView, targetView)
        }
        
        if let builder = item.makeCTVFL {
            measure(.ctvfl) {
                _ = builder(rootView, targetView)
            }
        }
        
        if let builder = item.makeSnapKit {
            measure(.snapKit) {
                _ = builder(rootView, targetView)
            }
        }
        
        if let builder = item.makeCartography {
            measure(.cartography) {
                _ = builder(rootView, targetView)
            }
        }
        
        endMeasure(animated: animated)
    }
}

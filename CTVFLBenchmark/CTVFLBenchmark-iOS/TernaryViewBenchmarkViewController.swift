//
//  TernaryViewBenchmarkViewController.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/30.
//

import UIKit

class TernaryViewBenchmarkViewController: BenchmarkViewController<TernaryBenchmarkItem> {
    var rootView: UIView!
    var view1: UIView!
    var view2: UIView!
    var view3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView = UIView()
        view1 = UIView()
        view2 = UIView()
        view3 = UIView()
        rootView.addSubview(view1)
        rootView.addSubview(view2)
        rootView.addSubview(view3)
    }
    
    var once: Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        if !once {
            beginMeasure()
            
            measure(.vfl) {
                _ = item.makeVFL(rootView, view1, view2, view2)
            }
            
            if let builder = item.makeCTVFL {
                measure(.ctvfl) {
                    _ = builder(rootView, view1, view2, view3)
                }
            }
            
            if let builder = item.makeSnapKit {
                measure(.snapKit) {
                    _ = builder(rootView, view1, view2, view3)
                }
            }
            
            if let builder = item.makeCartography {
                measure(.cartography) {
                    _ = builder(rootView, view1, view2, view3)
                }
            }
            
            endMeasure(animated: animated)
            once = true
        }
    }
}

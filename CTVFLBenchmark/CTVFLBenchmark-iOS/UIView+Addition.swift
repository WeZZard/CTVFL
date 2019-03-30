//
//  UIView+Addition.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/30.
//

import UIKit


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return unsafeDowncast(
            Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as AnyObject,
            to: T.self
        )
    }
}

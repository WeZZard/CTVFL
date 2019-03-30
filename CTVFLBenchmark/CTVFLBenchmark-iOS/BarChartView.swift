//
//  BarChartView.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/30.
//

import UIKit

@IBDesignable
class BarChartView: UIView {
    let nibName = "BarChartView"
    var contentView: UIView?
    
    @IBOutlet weak var ctvflBarContainer: UIView!
    
    @IBOutlet weak var vflBarContainer: UIView!
    
    @IBOutlet weak var cartographyBarContainer: UIView!
    
    @IBOutlet weak var snapKitBarContainer: UIView!
    
    @IBOutlet weak var ctvflBar: UIView!
    
    @IBOutlet weak var vflBar: UIView!
    
    @IBOutlet weak var cartographyBar: UIView!
    
    @IBOutlet weak var snapKitBar: UIView!
    
    @IBOutlet weak var ctvflReader: UILabel!
    
    @IBOutlet weak var vflReader: UILabel!
    
    @IBOutlet weak var cartographyReader: UILabel!
    
    @IBOutlet weak var snapKitReader: UILabel!
    
    @IBOutlet weak var ctvflBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var vflBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cartographyBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var snapKitBarHeightConstraint: NSLayoutConstraint!
    
    var _consumedTimes: [Key: CFTimeInterval] = [:]
    
    var _multipliers: [Key: CGFloat] = [:]
    
    var _constraints: [Key: NSLayoutConstraint] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func _multiplier(for key: Key) -> CGFloat {
        return _multipliers[key] ?? 0
    }
    
    func beginUpdateData (){
        
    }
    
    func endUpdateData(animated: Bool) {
        let maxTime = _consumedTimes.map({$0.value}).max() ?? 0
        
        if maxTime > 0 + 0.000001 {
            for each in Key.allCases {
                let multiplier = (_consumedTimes[each] ?? 0) / maxTime
                _multipliers[each] = CGFloat(multiplier)
            }
        }
        
        _didUpdateData(animated: animated)
    }
    
    func _didUpdateData(animated: Bool) {
        ctvflBarHeightConstraint.isActive = false
        vflBarHeightConstraint.isActive = false
        cartographyBarHeightConstraint.isActive = false
        snapKitBarHeightConstraint.isActive = false
        
        ctvflBarHeightConstraint = ctvflBar.heightAnchor.constraint(equalTo: ctvflBarContainer.heightAnchor, multiplier: _multiplier(for: .ctvfl))
        ctvflBarContainer.addConstraint(ctvflBarHeightConstraint)
        vflBarHeightConstraint = vflBar.heightAnchor.constraint(equalTo: vflBarContainer.heightAnchor, multiplier: _multiplier(for: .vfl))
        vflBarContainer.addConstraint(vflBarHeightConstraint)
        cartographyBarHeightConstraint = cartographyBar.heightAnchor.constraint(equalTo: cartographyBarContainer.heightAnchor, multiplier: _multiplier(for: .cartography))
        cartographyBarContainer.addConstraint(cartographyBarHeightConstraint)
        snapKitBarHeightConstraint = snapKitBar.heightAnchor.constraint(equalTo: snapKitBarContainer.heightAnchor, multiplier: _multiplier(for: .snapKit))
        snapKitBarContainer.addConstraint(snapKitBarHeightConstraint)
        
        setNeedsUpdateConstraints()
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.layoutIfNeeded()
                let transitionOptions: UIView.AnimationOptions = [.transitionCrossDissolve, .showHideTransitionViews]
                UIView.transition(with: self.ctvflReader, duration: 0.3, options: transitionOptions, animations: {
                    self.ctvflReader.text = self[.ctvfl]
                }, completion: nil)
                UIView.transition(with: self.vflReader, duration: 0.3, options: transitionOptions, animations: {
                    self.vflReader.text = self[.vfl]
                }, completion: nil)
                UIView.transition(with: self.cartographyReader, duration: 0.3, options: transitionOptions, animations: {
                    self.cartographyReader.text = self[.cartography]
                }, completion: nil)
                UIView.transition(with: self.snapKitReader, duration: 0.3, options: transitionOptions, animations: {
                    self.snapKitReader.text = self[.snapKit]
                }, completion: nil)
            }, completion: nil)
        } else {
            layoutIfNeeded()
            self.ctvflReader.text = self[.ctvfl]
            self.vflReader.text = self[.vfl]
            self.cartographyReader.text = self[.cartography]
            self.snapKitReader.text = self[.snapKit]
        }
    }
    
    func _constraint(for key: Key) -> NSLayoutConstraint {
        return _constraints[key]!
    }
    
    func _setConstraint(_ constraint: NSLayoutConstraint, for key: Key) {
        _constraints[key] = constraint
    }
    
    subscript(key: Key) -> CFTimeInterval {
        get { return _consumedTimes[key] ?? 0 }
        set { _consumedTimes[key] = newValue }
    }
    
    subscript(key: Key) -> String {
        get {
            if let duration = _consumedTimes[key] {
                return String(format: "%.3fs", duration)
            } else {
                return "No Equivalent Expression"
            }
        }
    }
    
    typealias Key = BenchmarkMeasureItem
}

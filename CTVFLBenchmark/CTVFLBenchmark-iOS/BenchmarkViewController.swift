//
//  BenchmarkViewController.swift
//  CTVFLBenchmark
//
//  Created on 2019/3/27.
//

import UIKit
import CTVFL

class BenchmarkViewController<Item: BenchmarkItem>: UIViewController, BenchmarkMeasuring {
    var item: Item
    
    var vfl: String { return item.vfl }
    
    var formatOptions: String { return item.formatOptions.description }
    
    var dataSet: [BenchmarkMeasureItem : (begin: CFTimeInterval, end: CFTimeInterval)] = [:]
    
    weak var vflLabel: UILabel!
    
    weak var formatOptionsLabel: UILabel!
    
    weak var descriptionLabel: UILabel!
    
    weak var barCharView: BarChartView!
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "@\"\(item.vfl)\""
        
        let _descriptionLabel = UILabel()
        _descriptionLabel.text = "Constraining \(item.description)."
        _descriptionLabel.textAlignment = .center
        _descriptionLabel.numberOfLines = 0
        
        let _vflTitleLabel = UILabel()
        _vflTitleLabel.text = "VFL String:"
        _vflTitleLabel.textAlignment = .left
        _vflTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let _vflLabel = UILabel()
        _vflLabel.text = "@\"\(item.vfl)\""
        _vflLabel.textAlignment = .right
        _vflLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let _formatOptionsTitleLabel = UILabel()
        _formatOptionsTitleLabel.text = "Format Options:"
        _formatOptionsTitleLabel.textAlignment = .left
        _formatOptionsTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let _formatOptionsLabel = UILabel()
        _formatOptionsLabel.text = item.formatOptions.description == "" ? "N/A" : item.formatOptions.description
        _formatOptionsLabel.textAlignment = .right
        _formatOptionsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let _barCharView: BarChartView = BarChartView.fromNib()
        
        view.addSubview(_descriptionLabel)
        view.addSubview(_vflTitleLabel)
        view.addSubview(_vflLabel)
        view.addSubview(_formatOptionsTitleLabel)
        view.addSubview(_formatOptionsLabel)
        view.addSubview(_barCharView)
        
        constrain {
            let vflLabels = _vflTitleLabel - (>=8) - _vflLabel
            let formatOptionsLabels = _formatOptionsTitleLabel - (>=8) - _formatOptionsLabel
            withVFL(H: view.safeAreaLayoutGuide - _descriptionLabel - view.safeAreaLayoutGuide)
            withVFL(H: view.safeAreaLayoutGuide - vflLabels - view.safeAreaLayoutGuide, options: [.alignAllCenterY])
            withVFL(H: view.safeAreaLayoutGuide - formatOptionsLabels - view.safeAreaLayoutGuide, options: [.alignAllCenterY])
            withVFL(H: view.safeAreaLayoutGuide - _barCharView - view.safeAreaLayoutGuide)
            
            let contentLabels = _vflLabel - _formatOptionsLabel
            let lables = _descriptionLabel - contentLabels
            
            withVFL(V: view.safeAreaLayoutGuide - lables - _barCharView - view.safeAreaLayoutGuide)
        }
        
        barCharView = _barCharView
    }
    
    func beginMeasure() {
        
    }
    
    func beginMeasurement(of item: BenchmarkMeasureItem) {
        if self.dataSet[item] == nil {
            let now = CACurrentMediaTime()
            self.dataSet[item] = (begin: now, end: now)
        } else {
            preconditionFailure()
        }
    }
    
    func endMeasurement(of item: BenchmarkMeasureItem) {
        if let (begin, _) = self.dataSet[item] {
            let now = CACurrentMediaTime()
            self.dataSet[item] = (begin: begin, end: now)
        } else {
            preconditionFailure()
        }
    }
    
    func endMeasure(animated: Bool) {
        barCharView.beginUpdateData()
        for (item, data) in self.dataSet {
            let (begin, end) = data
            let duration = end - begin
            barCharView[item] = duration
        }
        barCharView.endUpdateData(animated: animated)
    }
}

enum BenchmarkMeasureItem: Hashable, CustomStringConvertible, CaseIterable {
    case vfl
    case ctvfl
    case cartography
    case snapKit
    
    var description: String {
        switch self {
        case .vfl:          return "VFL"
        case .ctvfl:        return "CTVFL"
        case .cartography:  return "Cartography"
        case .snapKit:      return "SnapKit"
        }
    }
}

protocol BenchmarkMeasuring: class {
    func beginMeasure()
    
    func beginMeasurement(of item: BenchmarkMeasureItem)
    
    func endMeasurement(of item: BenchmarkMeasureItem)
    
    func endMeasure(animated: Bool)
}

extension BenchmarkMeasuring {
    func measure(_ item: BenchmarkMeasureItem, with block: () -> Void) {
        self.beginMeasurement(of: item)
        for _ in 0..<10000 {
            block()
        }
        self.endMeasurement(of: item)
    }
}

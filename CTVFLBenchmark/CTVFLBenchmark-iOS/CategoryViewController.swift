//
//  ViewController.swift
//  CTVFLBenchmark-iOS
//
//  Created by Yu-Long Li on 2019/3/27.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    var benchmarkItemGroups: [[BenchmarkItem]] = [
        unaryBenchmarkItems,
        binaryBenchmarkItems,
        ternaryBenchmarkItems,
    ]
    
    var mainStoryboard: UIStoryboard!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return benchmarkItemGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return benchmarkItemGroups[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "VFL with 1 View"
        case 1: return "VFL with 2 Views"
        case 2: return "VFL with 3 Views"
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let benchmarkItemGroup = benchmarkItemGroups[indexPath.section]
        let item = benchmarkItemGroup[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "benchmarkItem", for: indexPath)
        cell.textLabel?.text = "@\"\(item.vfl)\""
        cell.detailTextLabel?.text = item.formatOptions.isEmpty ? "N/A" : "\(item.formatOptions)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let benchmarkItemGroup = benchmarkItemGroups[indexPath.section]
        let item = benchmarkItemGroup[indexPath.item]
        
        var viewController: UIViewController?
        
        switch item {
        case let unaryItem as UnaryBenchmarkItem:
            let unaryViewBenchmarkViewController = UnaryViewBenchmarkViewController(item: unaryItem)
            viewController = unaryViewBenchmarkViewController
        case let binaryItem as BinaryBenchmarkItem:
            let binaryViewBenchmarkViewController = BinaryViewBenchmarkViewController(item: binaryItem)
            viewController = binaryViewBenchmarkViewController
        case let ternaryItem as TernaryBenchmarkItem:
            let ternaryViewBenchmarkViewController = TernaryViewBenchmarkViewController(item: ternaryItem)
            viewController = ternaryViewBenchmarkViewController
        default:
            break
        }
        
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

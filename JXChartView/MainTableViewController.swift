//
//  MainTableViewController.swift
//  JXChartView
//
//  Created by 杜进新 on 2017/8/8.
//  Copyright © 2017年 dujinxin. All rights reserved.
//

import UIKit

private let cellIdentifier = "cellIdentifier"

class MainTableViewController: UITableViewController {

    var dataArray = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataArray.append("barChart")
        dataArray.append("lineChart")
        dataArray.append("combineChart")
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier {
            case "barChart":
                let vc = segue.destination as! BarChartViewController
                vc.title = identifier
            case "lineChart":
                let vc = segue.destination as! LineChartViewController
                vc.title = identifier
            case "combineChart":
                let vc = segue.destination as! CombineChartViewController
                vc.title = identifier
            default:
                break
            }
        }

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = dataArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "barChart", sender: nil)
        case 1:
            performSegue(withIdentifier: "lineChart", sender: nil)
        case 2:
            performSegue(withIdentifier: "combineChart", sender: nil)
        default:
            break
        }
    }

}

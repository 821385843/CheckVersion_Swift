//
//  MainTableViewController.swift
//  CheckVersion_Swift_Example
//
//  Created by Xie Wei on 2019/9/9.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MainCell"
let kAppId = "414478124"

class MainTableViewController: UITableViewController {
    
    lazy var dataArr = ["显示从 Apple API 获取的更新内容", "显示自定义的更新内容", "显示自定义 View"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "目录"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = UIViewController()
        if indexPath.row == 0 {
            vc = FirstViewController()
        } else if indexPath.row == 1 {
            vc = SecondViewController()
        } else {
            vc = ThirdViewController()
        }
        vc.title = dataArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

//
//  FirstViewController.swift
//  CheckVersion_Swift_Example
//
//  Created by Xie Wei on 2019/9/9.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CheckVersion_Swift

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            CheckVersion.checkVersion(kAppId, nil)
        }
    }

}

//
//  ViewController.swift
//  CheckVersion_Swift
//
//  Created by Wade on 03/04/2019.
//  Copyright (c) 2019 Wade. All rights reserved.
//

import UIKit
import CheckVersion_Swift

// 414478124 : app id of the wechat
private let kAppId = "414478124"

class ViewController: UIViewController {
    
    @IBOutlet weak var customContentTextView: UITextView!
    
    
    @IBAction func showAppleAPIContent(_ sender: UIButton) {
        CheckVersion.checkVersion(kAppId, nil)
    }
    
    @IBAction func showCustomContent(_ sender: UIButton) {
        CheckVersion.checkVersion(kAppId, customContentTextView.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


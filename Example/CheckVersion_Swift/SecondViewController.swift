//
//  SecondViewController.swift
//  CheckVersion_Swift_Example
//
//  Created by Xie Wei on 2019/9/9.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CheckVersion_Swift

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let customContent = "- 首页：余额宝、定期、基金、黄金，品类齐全，灵活稳健；最懂你的财富头条来了，与你相关的资讯都在这里；\n\r- 股票：股票行情全新体验，聚焦股票自选，夜间模式更清晰；"
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            CheckVersion.checkVersion(kAppId, { (responseDict) in
                let message = customContent
                let alertContent = "\(message)\n\n是否前往 AppStore 更新版本？"
                let trackViewUrlString = responseDict["trackViewUrl"] as? String
                
                UIAlertController.alertTip(alertContent, trackViewUrlString)
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ThirdViewController.swift
//  CheckVersion_Swift_Example
//
//  Created by Xie Wei on 2019/9/9.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CheckVersion_Swift

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let customContent = "- 首页：余额宝、定期、基金、黄金，品类齐全，灵活稳健；最懂你的财富头条来了，与你相关的资讯都在这里；\n\r- 股票：股票行情全新体验，聚焦股票自选，夜间模式更清晰；"
        let content = "\(customContent)\n\n\n\n是否前往 AppStore 更新版本？"
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            CheckVersion.checkVersion(kAppId, { (responseDict) in
                guard let trackViewUrlStr = responseDict["trackViewUrl"] as? String,
                    let appStoreURL = URL(string: trackViewUrlStr)
                    else {
                        return
                }
                
                let appVersion = AppVersion.shared
                appVersion.updateBtnClickCompletion = {
                    if UIApplication.shared.canOpenURL(appStoreURL) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                            UIApplication.shared.openURL(appStoreURL)
                        }
                    }
                }
                appVersion.show(content)
            })
        }
    }

}

//
//  UIAlertController+tip.swift
//  iTunesUpdateApp
//
//  Created by xie wei on 2019/3/1.
//  Copyright © 2019 xie wei. All rights reserved.
//

import UIKit

private var kContentLabKey = ""

public extension UIAlertController {
    
    var contentLab: UILabel? {
        get {
            return objc_getAssociatedObject(self, &kContentLabKey) as? UILabel
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kContentLabKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    class func alertTip(_ contentString: String?, _ trackViewUrlString: String?) {
        
        guard let content = contentString,
            let trackViewUrlStr = trackViewUrlString,
            let appStoreURL = URL(string: trackViewUrlStr)
            else {
                return
        }
        
        let alertVC = UIAlertController(title: "更新", message: content, preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "前往", style: .default) { (action) in
            if UIApplication.shared.canOpenURL(appStoreURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(appStoreURL)
                }
            }
        }
        alertVC.addAction(action)
        alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        setContentLabAlignment(alertVC)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    
    class func getLabs(_ view: UIView, _ alertVC: UIAlertController) {
        var isExist = false
        
        let subviews = view.subviews
        for v in subviews {
            if v.isKind(of: UILabel.self) {
                let lab = v as! UILabel
                if lab.text == (alertVC.message ?? "") {
                    isExist = true
                    alertVC.contentLab = lab
                    break
                }
            }
        }
        
        if !isExist && subviews.count > 0 {
            getLabs(subviews.first ?? UIView(), alertVC)
        }
    }
    
    class func setContentLabAlignment(_ alertVC: UIAlertController) {
        getLabs(alertVC.view, alertVC)
        alertVC.contentLab?.textAlignment = .left
    }
}

//
//  XWCheckVersion.swift
//  iTunesUpdateApp
//
//  Created by xie wei on 2019/3/1.
//  Copyright © 2019 xie wei. All rights reserved.
//

import UIKit


public func XWLog<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    #endif
}

public class CheckVersion: NSObject {
    
    /// 检查 app 是否需要去 AppStore 做版本更新
    ///
    /// - Parameters:
    ///   - appId: appId
    ///   - completion: completion ！= nil时，显示自定义 view；completion == nil时，直接显示弹出框（显示API 请求内容）
    public class func checkVersion(_ appId: String, _ completion: ((_ dict: [String: Any]) -> ())?) {
        if completion == nil {
            requestAPI(appId) { (responseDict) in
                let message = responseDict["releaseNotes"] as? String ?? ""
                let alertContent = "\(message)\n\n是否前往 AppStore 更新版本？"
                let trackViewUrlString = responseDict["trackViewUrl"] as? String
                
                UIAlertController.alertTip(alertContent, trackViewUrlString)
            }
        } else {
            requestAPI(appId, completion: completion)
        }
    }
    
    class func requestAPI(_ appId: String, completion: ((_ dict: [String: Any]) -> ())?) {
        let kItunesURL = "http://itunes.apple.com/lookup?id=\(appId)"
        XWLog(kItunesURL)
        
        guard let url = URL(string: kItunesURL) else {
            XWLog("\(kItunesURL) is wrong.")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {(responseData, response, error) in
            guard let data = responseData else {
                XWLog("response data is nil.")
                return
            }
            
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String: Any]
                XWLog(dict)
                
                guard let resultsArray = dict["results"] else {
                    XWLog("results dictionary is nil.")
                    return
                }
                
                let results = resultsArray as! [[String: Any]]
                if results.count > 0 {
                    let responseDict = results.first ?? [:]
                    let currentBundleShortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
                    let lastVersion = responseDict["version"] as? String ?? ""
                    
                    /// to update
                    if currentBundleShortVersion.compare(lastVersion) == .orderedAscending {
                        completion?(responseDict)
                    }
                }
            } catch {
                XWLog(error)
            }
        }
        dataTask.resume()
    }
}

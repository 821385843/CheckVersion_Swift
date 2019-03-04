//
//  XWCheckVersion.swift
//  iTunesUpdateApp
//
//  Created by 谢伟 on 2019/3/1.
//  Copyright © 2019 谢伟. All rights reserved.
//

import UIKit


public func XWLog<T>(_ message : T, file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    #endif
}

public class CheckVersion: NSObject {
    
    /// check version
    ///
    /// - Parameters:
    ///   - appId: app id,eg: 414478124 of the wechat
    ///   - customContent: custom content,if the string is nil and the count of the string is greater than zero,use custom content；Otherwise,use the content of the request data
    public class func checkVersion(_ appId: String, _ customContent: String?) {
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
                        let message = ((customContent != nil && (customContent ?? "").count > 0) ? customContent : (responseDict["releaseNotes"] as? String ?? ""))
                        let alertContent = "\(message ?? "")\n\n是否前往 AppStore 更新版本？"
                        let trackViewUrlString = responseDict["trackViewUrl"] as? String
                        
                        UIAlertController.alertTip(alertContent, trackViewUrlString)
                    }
                }
                
            } catch {
                XWLog(error)
            }
        }
        dataTask.resume()
    }
    
}

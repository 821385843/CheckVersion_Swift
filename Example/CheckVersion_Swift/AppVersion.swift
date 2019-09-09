//
//  AppVersion.swift
//  CheckVersion_Swift_Example
//
//  Created by Xie Wei on 2019/9/9.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class AppVersion: UIView {
    
    static let shared: AppVersion = {
        let shared = AppVersion(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        shared.center = UIApplication.shared.keyWindow!.center
        return shared
    }()
    
    var updateBtnClickCompletion: (() -> ())?
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 380))
        view.backgroundColor = UIColor.white
        view.center = self.center
        return view
    }()
    
    lazy var imgView: UIImageView = {
        let img = UIImage(named: "ad_top")
        let imgView = UIImageView(image: img)
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.text = "升级到新版本"
        titleLab.font = UIFont.boldSystemFont(ofSize: 18)
        titleLab.textColor = UIColor.black
        return titleLab
    }()
    
    lazy var contentTV: UITextView = {
        let contentTV = UITextView()
        contentTV.textColor = UIColor.black
        return contentTV
    }()
    
    lazy var updateBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("立即更新", for: .normal)
        btn.backgroundColor = UIColor(red: 226.0/255.0, green: 112.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(updateBtnClick), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        addSubview(contentView)
        contentView.addSubview(imgView)
        imgView.addSubview(closeBtn)
        contentView.addSubview(titleLab)
        contentView.addSubview(contentTV)
        contentView.addSubview(updateBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let img = UIImage(named: "ad_top")
        let imgViewW = contentView.frame.width
        let imgViewH = imgViewW * img!.size.height / img!.size.width
        imgView.frame = CGRect(x: 0, y: -20, width: imgViewW, height: imgViewH)
        
        let closeImg = UIImage(named: "close")
        let closeBtnX = imgView.frame.width - closeImg!.size.width - 10
        let closeBtnY: CGFloat = 30
        closeBtn.frame = CGRect(x: closeBtnX, y: closeBtnY, width: closeImg!.size.width, height: closeImg!.size.height)
        
        let titleLabToImgView: CGFloat = 5.0
        let titleLabX: CGFloat = 17.0
        let titleLabY = imgView.frame.maxY + titleLabToImgView
        let titleLabW = contentView.frame.width - titleLabX * 2
        let titleLabH: CGFloat = 30.0
        titleLab.frame = CGRect(x: titleLabX, y: titleLabY, width: titleLabW, height: titleLabH)
        
        let updateBtnH: CGFloat = 30.0
        let updateBtnToContentTV: CGFloat = 15.0
        
        let contentTVY = titleLab.frame.maxY + 5
        let contentTVH = contentView.frame.height - titleLab.frame.maxY - titleLabToImgView - updateBtnH - updateBtnToContentTV * 2
        contentTV.frame = CGRect(x: titleLabX, y: contentTVY, width: titleLabW, height: contentTVH)
        
        let updateBtnY = contentTV.frame.maxY + updateBtnToContentTV
        updateBtn.frame = CGRect(x: titleLabX, y: updateBtnY, width: titleLabW, height: updateBtnH)
    }
    
    func show(_ content: String?) {
        DispatchQueue.main.async {
            let appVersion = AppVersion.shared
            appVersion.contentTV.text = content
            UIApplication.shared.keyWindow?.addSubview(appVersion)
        }
    }
    
    @objc func closeBtnClick() {
        AppVersion.shared.removeFromSuperview()
    }
    
    @objc func updateBtnClick() {
        updateBtnClickCompletion?()
    }
}

//
//  ViewController.swift
//  WindowLogin
//
//  Created by zhaojw on 2017/11/2.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {
    
    lazy var  effectView: NSVisualEffectView = {
        let effectView = NSVisualEffectView()
        effectView.wantsLayer   = true
        effectView.material     = .light
        effectView.state        = .active
        effectView.blendingMode = .withinWindow
        return effectView
    }()
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.red.cgColor
        effectView.frame = view.bounds
        view.addSubview(effectView, positioned: .below, relativeTo: view.subviews[0])
    }
    
    
    
    @IBAction func loginButtonAction(_ sender: NSButton) {
        //此数省略服务器登录验证
        //关闭窗口
        self.view.window?.close()
        //登录完成发送通知消息
        NotificationCenter.default.post(name: Notification.Name.loginOK, object: nil)
    }
    
    
    @IBAction func closeButtonAction(_ sender: NSButton) {
        self.view.window?.close()
    }
}

extension Notification.Name {
    //定义消息通知名称
    static let loginOK     = Notification.Name("loginOK")
}

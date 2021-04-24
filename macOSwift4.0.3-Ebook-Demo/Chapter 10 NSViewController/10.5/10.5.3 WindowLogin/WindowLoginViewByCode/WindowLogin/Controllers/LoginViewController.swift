//
//  ViewController.swift
//  WindowLogin
//
//  Created by zhaojw on 2017/11/2.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa



class LoginViewController: NSViewController {
    
    lazy var closeButton: NSButton = {
        let button = NSButton()
        button.isBordered = false
        button.image = NSImage(named: NSImage.Name("ic_close"))
        button.imageScaling = .scaleProportionallyUpOrDown
        button.translatesAutoresizingMaskIntoConstraints = false
        button.target = self
        button.action = #selector(self.closeButtonAction(_:))
        return button
    }()
    
    lazy var imageView: NSImageView = {
        let imageView    = NSImageView()
        imageView.image = NSImage(named: NSImage.Name("ic_face"))
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var userNameField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "login name"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var passwordField: NSSecureTextField =  {
        let field = NSSecureTextField()
        field.placeholderString = "password"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var loginButton: NSButton = {
        let button = NSButton()
        button.bezelStyle = .rounded
        button.setButtonType(NSButton.ButtonType.momentaryPushIn)
        button.title = "Login"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.target = self
        button.action = #selector(self.loginButtonAction(_:))
        return button
    }()
    
    lazy var  effectView: NSVisualEffectView = {
        let effectView = NSVisualEffectView()
        effectView.wantsLayer   = true
        effectView.material     = .light
        effectView.state        = .active
        effectView.blendingMode = .withinWindow
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupAutoLayout()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.isRestorable = false
        self.view.window?.center()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.red.cgColor
        effectView.frame = view.bounds
        view.addSubview(effectView, positioned: .below, relativeTo: view.subviews[0])
    }
    
    func addSubviews() {
        view.addSubview(closeButton)
        view.addSubview(imageView)
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
    }
    
    func setupAutoLayout() {
        closeButton.top     = 6
        closeButton.left    = 6
        closeButton.width   = 12
        closeButton.height  = 12
        
        imageView.top       = 36
        imageView.centerX   = view.centerX
        imageView.width     = 78
        imageView.height    = 78
        
        userNameField.top     = imageView.bottom + 34
        userNameField.centerX = view.centerX
        userNameField.width   = 181
        userNameField.height  = 22
        
        passwordField.top     = userNameField.bottom + 10
        passwordField.centerX = view.centerX
        passwordField.width   = 181
        passwordField.height  = 22
        
        loginButton.top       = passwordField.bottom + 27
        loginButton.centerX   = view.centerX
        loginButton.width     = 78
        loginButton.height    = 21
    }
    
    override func loadView() {
        let frame = CGRect(x: 0, y: 0, width: 230, height: 270)
        let view = NSView(frame: frame)
        self.view = view
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

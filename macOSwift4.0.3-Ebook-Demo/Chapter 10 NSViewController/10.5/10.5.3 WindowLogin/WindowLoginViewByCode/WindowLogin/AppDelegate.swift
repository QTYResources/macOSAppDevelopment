//
//  AppDelegate.swift
//  WindowLogin
//
//  Created by zhaojw on 2017/11/2.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var windowController: MainWindowController? =  {
        let wvc = MainWindowController()
        return wvc
    }()
    
    lazy var loginWindowController: LoginWindowController? =  {
         let wvc = LoginWindowController()
         return wvc
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        loginWindowController?.showWindow(self)
        registerNotification()
    }
    
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.onLoginOK(_:)),  name:NSNotification.Name.loginOK, object: nil)
    }
    
    @objc func onLoginOK(_ notification: Notification){
       windowController?.showWindow(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        windowController = nil
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}


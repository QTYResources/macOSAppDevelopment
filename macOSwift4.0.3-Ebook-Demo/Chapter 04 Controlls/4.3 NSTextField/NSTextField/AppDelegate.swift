//
//  AppDelegate.swift
//  NSTextField
//
//  Created by iDevFans on 16/6/28.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate,NSTextFieldDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var userNameField: NSTextField!
    
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    override func controlTextDidBeginEditing(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            let text = textField.stringValue
            if(textField == self.userNameField){
                print("userName:\(text)")
            }
            if(textField == self.passwordTextField){
                print("password:\(text)")
            }
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
   
        if let textField = obj.object as? NSTextField {
            let text = textField.stringValue
            if(textField == self.userNameField){
                print("userName:\(text)")
            }
            if(textField == self.passwordTextField){
                print("password:\(text)")
            }
        }
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            // Press ENTER key
            print("enter")
            return true
        } else if (commandSelector == #selector(NSResponder.deleteForward(_:))) {
            // Press DELETE key
            return true
        } else if (commandSelector == #selector(NSResponder.deleteBackward(_:))) {
            // Press BACKSPACE key
            return true
        } else if (commandSelector == #selector(NSResponder.insertTab(_:))) {
            // Press TAB key
            return true
        } else if (commandSelector == #selector(NSResponder.cancelOperation(_:))) {
            // Press ESC key
            return true
        }
        return false
    }

}







//
//  ViewController.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/21.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var gEventHandler: Any?
    var lEventHandler: Any?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startGlobalEventMoniter()
        self.startLocalEventMoniter()
        
        self.view.window?.makeFirstResponder(self)
    }

    override func mouseDown(with event: NSEvent) {
        
        print("mouseDown event \(event)")
    }
    
    override func keyDown(with event: NSEvent) {
        print("keyDown event \(event)")
    }

    func startGlobalEventMoniter() {
        self.gEventHandler = NSEvent.addGlobalMonitorForEvents(matching: [NSEvent.EventTypeMask.keyDown,NSEvent.EventTypeMask.leftMouseDown], handler: {  event in
           
            print("global event \(event)")
        })
    }
    
    
    
    
    func startLocalEventMoniter() {
        self.lEventHandler = NSEvent.addLocalMonitorForEvents(matching: [NSEvent.EventTypeMask.keyDown,NSEvent.EventTypeMask.leftMouseDown], handler: {event in
            print("local event \(event)")
            return event
          }
        )
    }
    
    
    func stopEventMoniter() {
        NSEvent.removeMonitor(self.gEventHandler!)
        NSEvent.removeMonitor(self.lEventHandler!)
    }

    
    
}


extension ViewController: NSTextFieldDelegate,NSTextViewDelegate {
    
     //MARK: NSTextFieldDelegate
    
     func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            NSLog("textField Enter key pressed!")
            return true
        }
        if commandSelector == #selector(NSResponder.deleteBackward(_:)) {
            NSLog("textField delete key pressed!")
            return true
        }
        
        return false
    }
    
    
    //MARK: NSTextViewDelegate
    
    func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(NSResponder.insertNewline(_:)) {
            NSLog("textView Enter key pressed!")
            return true
        }
        if commandSelector == #selector(NSResponder.deleteBackward(_:)) {
            NSLog("textView delete key pressed!")
            return true
        }
        
        if commandSelector == #selector(NSResponder.insertTab(_:)) {
            NSLog("textView tab key pressed!")
            return true
        }
        
        return false
    }
}






//
//  ViewController.swift
//  NSUndoManager
//
//  Created by iDevFans on 16/7/24.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa



class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(NSNotification.Name.NSUndoManagerWillUndoChange)")
        
        

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func changeFillColorAction(_ sender: NSButton) {
        
    }
    
    var fillColor: NSColor?
    func changeFillColor(_ color:NSColor) {
        let oldColor = self.fillColor
        let undoManager = self.undoManager
        //将修改前操作注册到栈(以对象self,方法changeFillColor，参数oldFillColor构造NSInvocation实例对象)
        if let target = undoManager?.prepare(withInvocationTarget: self) as? ViewController {
            target.changeColor(oldColor)
        }
        self.fillColor = color
        self.reDraw()
        
        self.observeValue(forKeyPath: <#T##String?#>, of: <#T##Any?#>, change: <#T##[NSKeyValueChangeKey : Any]?#>, context: <#T##UnsafeMutableRawPointer?#>)
    }

    
    func reDraw() {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = self.fillColor?.cgColor
    }
    
    @objc func setMyObjectTitle(_ title: String) {
        self.title = title
    }
    
    func createUndo1(){
        self.undoManager?.registerUndo(withTarget: self, selector:
            #selector(ViewController.setMyObjectTitle(_:)),object: "currentTitle")
    }
    
    func createUndo2(){
        
        if let target = undoManager?.prepare(withInvocationTarget: self) as? ViewController {
            target.setMyObjectTitle("currentTitle")
        }
        
    }
    
    
}



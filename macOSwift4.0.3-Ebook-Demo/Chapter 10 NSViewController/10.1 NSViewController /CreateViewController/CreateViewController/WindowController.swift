//
//  WindowController.swift
//  CreateViewController
//
//  Created by iDevFans on 16/7/15.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        //切换不同的方法去创建viewcontroller
        
        //self.createVC1()
        
        //self.createVC2()
        
        //self.createVC3()
        
  
        //self.createVC4()
        
        
        self.createVC5()

        
    }
    
    func createVC1() {
        
        let testViewController = TestViewController(nibName: NSNib.Name(rawValue: "TestViewController"), bundle: nil)
        self.contentViewController = testViewController
        
    }
    
    
    func createVC2() {
        let sbName = NSStoryboard.Name(rawValue: "Storyboard")
        let storyboard = NSStoryboard(name:sbName, bundle: nil)
        let myViewController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "myVC"))
        self.contentViewController = myViewController as? NSViewController
    }
    
    func createVC3() {
        
        let viewController = NSViewController()
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSView(frame: frame)
        viewController.view = view;

        self.contentViewController = viewController
        
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "PresentVC")
        
    }
    
    

    func createVC4() {
        
        let loadViewController = LoadViewController()
        self.contentViewController = loadViewController
        
    }
    
    func createVC5() {
        
        let loadViewController = Test2ViewController()
        self.contentViewController = loadViewController
        
    }
    
}



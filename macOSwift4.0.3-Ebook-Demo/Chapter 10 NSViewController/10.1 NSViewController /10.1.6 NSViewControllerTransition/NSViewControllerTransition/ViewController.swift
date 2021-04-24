//
//  ViewController.swift
//  NSViewControllerTransition
//
//  Created by iDevFans on 16/7/16.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa



class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //创建手势类
        let gr = NSMagnificationGestureRecognizer(target: self, action: #selector(ViewController.magnify(_:)))
        
        //视图增加手势识别
        self.view.addGestureRecognizer(gr)
       
        gr.delegate = self
        
        self.view.window?.makeKeyAndOrderFront(self)

    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func presentAsModalAction(_ sender: NSButton){
        let presentVC = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PresentVC")) as? NSViewController
        self.presentViewControllerAsModalWindow(presentVC!)
    }
    

    @IBAction func presentAsSheetAction(_ sender: NSButton){
        let presentVC = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PresentVC")) as? NSViewController
        self.presentViewControllerAsSheet(presentVC!)
    }
    
    
    @IBAction func presentAsPopoverAction(_ sender: NSButton){
        
        let presentVC = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PresentVC")) as? NSViewController
        
        self.presentViewController(presentVC!, asPopoverRelativeTo: sender.frame, of: self.view, preferredEdge: .minY, behavior:.transient )
    }
    
    
    @IBAction func presentAsAnimatorAction(_ sender: NSButton){
        
        let presentVC = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PresentVC")) as? NSViewController
        
        let animator = PresentCustomAnimator()
        
        self.presentViewController(presentVC!, animator: animator)
    }
    
    @IBAction func showAction(_ sender: NSButton){

        let presentVC = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PresentVC")) as? NSViewController
        let toVC = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "toVC")) as? NSViewController
        //增加 2个子视图控制器
        self.addChildViewController(presentVC!)
        self.addChildViewController(toVC!)
        //显示 presentVC 视图
        self.view.addSubview((presentVC?.view)!)
        // 从 presentVC 视图 切换到另外一个 toVC 视图
        self.transition(from: presentVC!, to: toVC!, options: NSViewController.TransitionOptions.crossfade , completionHandler: nil)
    }
    
}

extension ViewController: NSGestureRecognizerDelegate {
    @objc func magnify(_ sender: NSMagnificationGestureRecognizer) {
        switch  sender.state {
        case .began:
            
            print("ClickGesture began")
            
        break
            
        case .changed:
            
            print("ClickGesture changed")
            
            break
            
        case .ended:
            
            print("ClickGesture ended")
            
            break
            
        case .cancelled:
            
            print("ClickGesture cancelled")
            
            break
            
        default : break
        
        
       }
    
    }

}





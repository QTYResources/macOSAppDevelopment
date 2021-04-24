//
//  ViewController.swift
//  CoreAnimation
//
//  Created by iDevFans on 16/10/10.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var myView: CustomView!
    
    @IBOutlet weak var view1: NSView!
    
    @IBOutlet weak var view2: NSView!
    
    var bgLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.wantsLayer = true
        
       // self.addSubLayer()
        
        //self.showPerspective()
        
       // self.addAnimationLayer()
        
        
       
    }
    
    
    func addSubLayer(){
        let parentLayer = self.view.layer
        let blueLayer = CALayer()
        blueLayer.frame = NSMakeRect(10, 10, 100, 100)
        blueLayer.backgroundColor = NSColor.blue.cgColor
        parentLayer?.addSublayer(blueLayer)
        
        let greenLayer = CALayer()
        greenLayer.frame = NSMakeRect(20, 20, 100, 100)
        greenLayer.backgroundColor = NSColor.green.cgColor
        parentLayer?.addSublayer(greenLayer)
        //greenLayer.zPosition  = 500
        
        let redLayer = CALayer()
        redLayer.frame = NSMakeRect(30, 30, 100, 100)
        redLayer.backgroundColor = NSColor.red.cgColor
        parentLayer?.addSublayer(redLayer)

    }
    
    func showPerspective(){
        
        let parentLayer = self.view.layer
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500
        parentLayer?.sublayerTransform = perspective
        let blueLayer = CALayer()
        blueLayer.frame = NSMakeRect(10, 10, 100, 100)
        blueLayer.backgroundColor = NSColor.blue.cgColor
        blueLayer.zPosition = 50
        parentLayer?.addSublayer(blueLayer)
        
        let greenLayer = CALayer()
        greenLayer.frame = NSMakeRect(20, 20, 100, 100)
        greenLayer.backgroundColor = NSColor.green.cgColor
        greenLayer.zPosition = 80
        parentLayer?.addSublayer(greenLayer)
        
        let redLayer = CALayer()
        redLayer.frame = NSMakeRect(30, 30, 100, 100)
        redLayer.backgroundColor = NSColor.red.cgColor
        redLayer.zPosition = 200
        parentLayer?.addSublayer(redLayer)
        
    }
    
    
    func addAnimationLayer(){
        let bgLayer = CALayer()
        bgLayer.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        bgLayer.backgroundColor = NSColor.red.cgColor

        //要求view使用层
        self.view.wantsLayer = true
        self.view.layer?.addSublayer(bgLayer)
        self.bgLayer = bgLayer
        
        
        let animation = CABasicAnimation()
        animation.fromValue = 10
        animation.toValue = 1
        bgLayer.add(animation, forKey: "property")
       
        bgLayer.setValue(Int(10.0), forKeyPath: "transform.translation.y")

    }
    
    @IBAction func changeOpacityAction(_ sender: AnyObject) {
        //self.bgLayer.opacity = 0.1
        self.view1.wantsLayer = true
        self.view1.layer?.backgroundColor = NSColor.red.cgColor
        self.view2.wantsLayer = true
        self.view2.layer?.backgroundColor = NSColor.yellow.cgColor
        
        self.animationContextTest()
    }
    
    @IBAction func animationAction(_ sender: AnyObject) {
        self.animation2()
    }
    
    @IBAction func customViewAnimationAction(_ sender: AnyObject) {
        self.myView.animator().frame = NSMakeRect(10,10,100,100)
        
        let ff = WebView()
    }
    
    
    func animation(){
        let animation = CABasicAnimation(keyPath: "transform")
        animation.duration = 2.0
        animation.autoreverses = true
        animation.repeatCount = 1000
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DTranslate(CATransform3DIdentity, 100, 100, 0))
        self.view.layer?.add(animation, forKey: "")
    }
    
    func animation2(){
        let startFrame = self.myView.frame
        let endFrame = NSMakeRect(100, 100, startFrame.size.width, startFrame.size.height)
        let dictionary: [NSViewAnimation.Key : Any] = [
            NSViewAnimation.Key.target : self.myView,
            NSViewAnimation.Key.startFrame :  NSValue(rect: startFrame),
            NSViewAnimation.Key.endFrame :  NSValue(rect: endFrame)
        ]
        let animation = NSViewAnimation(viewAnimations: [dictionary])
        animation.duration = 2
        animation.animationBlockingMode = .nonblockingThreaded
        animation.animationCurve = .easeInOut
        animation.start()
    }
    
    func time(){
        let theAnimation = CABasicAnimation(keyPath: "transform")
        let localLayerTime = bgLayer.convertTime(CACurrentMediaTime(), from: nil)
        theAnimation.beginTime = localLayerTime + 2
        theAnimation.duration = 5.0
        
        
        let animation = CABasicAnimation()
        animation.toValue = 0.5
        bgLayer.add(animation, forKey: "opacity")
        
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        self.bgLayer.position = CGPoint(x: 10, y: 10)
        self.bgLayer.opacity = 0.1
        CATransaction.commit()
        
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        self.bgLayer.opacity = 0.2
        CATransaction.commit()

    }
    
    
    func animationContextTest(){
        
        let  toValue1 =  NSMakeRect(10,10,100,100)
        let  toValue2 =  NSMakeRect(80,100,100,100)

        NSAnimationContext.runAnimationGroup({(NSAnimationContext) -> Void in
            self.view1.animator().frame = toValue1
            }, completionHandler: {() -> Void in
                NSAnimationContext.runAnimationGroup({(NSAnimationContext) -> Void in
                    self.view2.animator().frame = toValue2
                    }, completionHandler: {() -> Void in
                })
        })

        
        NSAnimationContext.current.allowsImplicitAnimation = true
        
        //允许隐式动画
        NSAnimationContext.current.allowsImplicitAnimation = true
        //允许使用层
        self.myView.wantsLayer = true
        //类似iOS直接修改Layer属性产生动画
        self.myView.layer?.backgroundColor = NSColor.red.cgColor
        
    }
    
    func animationAutolayoutTest(){
        
        let constraint =  NSLayoutConstraint()
        
        self.myView.addConstraint(constraint)
        
        NSAnimationContext.runAnimationGroup({ context in
           
            context.allowsImplicitAnimation = true
            
            self.myView.layoutSubtreeIfNeeded()
            // OR  self.myView.window?.layoutIfNeeded()
            
        }, completionHandler: nil)
        
        
    }
    
    
    var keyframeAnimationWC: KeyframeAnimationWC?
    var pathAnimationWC: PathAnimationWC?
    var groupAnimationWC: GroupAnimationWC?
    var transitionAnimationWC: TransitionAnimationWC?
    @IBAction func keyframeAction(_ sender: AnyObject) {
        keyframeAnimationWC = KeyframeAnimationWC()
        keyframeAnimationWC?.showWindow(self)
    }
    
    @IBAction func pathAnimationAction(_ sender: AnyObject) {
        pathAnimationWC = PathAnimationWC()
        pathAnimationWC?.showWindow(self)
    }
    
    @IBAction func groupAnimationAction(_ sender: AnyObject) {
        groupAnimationWC = GroupAnimationWC()
        groupAnimationWC?.showWindow(self)
    }
    
    
    
    @IBAction func transitionAnimationAction(_ sender: AnyObject) {
        transitionAnimationWC = TransitionAnimationWC()
        transitionAnimationWC?.showWindow(self)
    }

    
    
    
    

}



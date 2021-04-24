//
//  ViewController.swift
//  NSSplitView
//
//  Created by iDevFans on 16/6/30.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var splitView: NSSplitView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createVSplitView()
        self.createHSplitView()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    func createVSplitView(){
        
        let frame = CGRect(x: 20, y: 100, width: 300, height: 200)
        splitView = NSSplitView(frame: frame)
        splitView.isVertical = true
        splitView.delegate = self
        splitView.dividerStyle = .thick
       // splitView.wantsLayer = true
        //splitView.layer?.borderWidth = 0.5
        //splitView.layer?.borderColor = NSColor.gray.cgColor

        let lframe = CGRect(x: 0, y: 0, width: 30, height: 200)
        let leftView = NSView(frame: lframe)
        leftView.wantsLayer = true
        leftView.layer?.backgroundColor = NSColor.green.cgColor

       
        let rframe = CGRect(x: 0, y: 0, width: 300, height: 200)
        let rightView = NSView(frame: rframe)
        rightView.wantsLayer = true
        rightView.layer?.backgroundColor = NSColor.red.cgColor

        splitView.addSubview(leftView)
        splitView.addSubview(rightView)
        
        self.view.addSubview(splitView)
        
        splitView.setPosition(60, ofDividerAt: 0)
    }
    
    
    func createHSplitView(){
        
        let frame = CGRect(x: 350, y: 100, width: 300, height: 200)
        let hsplitView = SplitView(frame: frame)
        hsplitView.isVertical = false
        hsplitView.delegate = self
        hsplitView.dividerStyle = .thick
        hsplitView.wantsLayer = true
        hsplitView.layer?.borderWidth = 0.5
        hsplitView.layer?.borderColor = NSColor.gray.cgColor
        
        let lframe = CGRect(x: 0, y: 0, width: 300, height: 60)
        let leftView = NSView(frame: lframe)
        leftView.wantsLayer = true
       // leftView.layer?.backgroundColor = NSColor.green.cgColor
        
        
        let rframe = CGRect(x: 0, y: 0, width: 300, height: 140)
        let rightView = NSView(frame: rframe)
        rightView.wantsLayer = true
       // rightView.layer?.backgroundColor = NSColor.red.cgColor
        
        hsplitView.addSubview(leftView)
        hsplitView.addSubview(rightView)
        
        self.view.addSubview(hsplitView)
        
        hsplitView.setPosition(60, ofDividerAt: 0)
    }
    
    var leftViewWidth: CGFloat = 0
    
    @IBAction func togglePanel(_ sender: NSButton) {
        let splitViewItem = splitView.arrangedSubviews
        let leftView  = splitViewItem[0]
        
        if splitView.isSubviewCollapsed(leftView){
            splitView.setPosition(leftViewWidth, ofDividerAt: 0)
            leftView.isHidden = false
        } else {
            leftViewWidth = leftView.frame.size.width
            splitView.setPosition(0, ofDividerAt: 0)
            leftView.isHidden = true
        }
        splitView.adjustSubviews()
    }
}



extension  ViewController: NSSplitViewDelegate {
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        if subview == splitView.subviews[0] {
            return true
        }
        return false
    }
    
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return 30
    }

    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
         return 100
    }
    
    
    func splitView(_ splitView: NSSplitView, shouldAdjustSizeOfSubview view: NSView) -> Bool {
         return true
    }
   
    func splitView(_ splitView: NSSplitView, shouldHideDividerAt dividerIndex: Int) -> Bool {
        return true
    }
    
//    func splitView(_ splitView: NSSplitView,
//                   constrainSplitPosition proposedPosition: CGFloat,
//                   ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return 4
//    }
}



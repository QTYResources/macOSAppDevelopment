//
//  ViewController.swift
//  ScrollViewButtons
//
//  Created by zhaojw on 2017/11/5.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

let kButtonWidth:  CGFloat = 80
let kButtonHeight: CGFloat = 20
let kButtonTopPaddding: CGFloat = 10
let kButtonLeftPaddding: CGFloat = 10

class ViewController: NSViewController {
    lazy var scrollView: NSScrollView = {
        let aScrollView = NSScrollView()
        aScrollView.focusRingType         = .none
        aScrollView.autohidesScrollers    = true
        aScrollView.hasHorizontalScroller = true
        aScrollView.borderType            = .bezelBorder
        aScrollView.translatesAutoresizingMaskIntoConstraints = false
        aScrollView.documentView = buttonView
        return aScrollView
    }()
    
    lazy var buttonView: ButtonView = {
        let view = ButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func newButton()-> NSButton {
        let button = NSButton()
        button.bezelStyle = .rounded
        button.font = NSFont.boldSystemFont(ofSize: 10.0)
        button.isBordered = true
        button.setButtonType(.pushOnPushOff)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    func addSubviews() {
        self.view.addSubview(self.scrollView)
        for i in 0...12 {
            let button = newButton()
            button.title = "Button\(i)"
            buttonView.addSubview(button)
        }
    }
    
    func setupAutoLayout() {
        
        self.scrollView.left   = 10
        self.scrollView.top    = 10
        self.scrollView.width  = 300
        self.scrollView.height = 50
        
        var lastView: NSView?
        var buttonViewWidth: CGFloat = 0
        for button in buttonView.subviews {
            button.centerY   = buttonView.centerY
            if let lastView = lastView {
                button.left = lastView.right + kButtonLeftPaddding
            }
            else {
                button.left = kButtonLeftPaddding
            }
            button.width   = kButtonWidth
            button.height  = kButtonHeight
            lastView = button
            // 计算 Button View 的宽度
            buttonViewWidth += (kButtonLeftPaddding + kButtonWidth)
        }
        
        buttonViewWidth +=  kButtonLeftPaddding
        
        buttonView.left     = self.scrollView.left
        buttonView.bottom   = self.scrollView.bottom
        buttonView.top      = self.scrollView.top
        
        var frame = buttonView.frame
        frame.size = NSSize(width: buttonViewWidth, height: NSView.noIntrinsicMetric)
        buttonView.viewSize = frame.size
        buttonView.invalidateIntrinsicContentSize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupAutoLayout()
    }
}


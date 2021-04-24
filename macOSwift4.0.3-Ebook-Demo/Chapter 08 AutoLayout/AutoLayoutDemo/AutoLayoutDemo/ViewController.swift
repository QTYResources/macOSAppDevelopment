//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by iDevFans on 16/9/25.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var contentView: NSView!
    
    lazy var controllers: [NSViewController] = {
      return [
        SimpleViewController(),
        TwoEqualWidthButtonsViewController(),
        ThreeEqualWidthButtonsViewController(),
        LabelTextFieldViewController()
        ]
    }()
    
    var index: Int = -1
    var currentView: NSView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeView()
    }

    
    func changeView() {
        if let view = currentView {
            view.removeFromSuperview()
        }
        
        if index == -1 {
            index = 0
        }
        
        let vc = self.controllers[index]
        currentView = vc.view
        contentView.addSubview(currentView!)
        contentView.translatesAutoresizingMaskIntoConstraints  = false
        currentView?.translatesAutoresizingMaskIntoConstraints = false
    
        
        currentView?.leading   =  contentView.leading
        currentView?.trailing  =  contentView.trailing
        currentView?.top    =  contentView.top
        currentView?.bottom =  contentView.bottom
    }
    
    
    @IBAction func preAction(_ sender: AnyObject) {
        if self.index - 1 >= 0 {
            self.index -= 1
            self.changeView()
        }
    }


    @IBAction func nextAction(_ sender: AnyObject) {
        let count = self.controllers.count
        if self.index + 1 <= count - 1 {
            self.index += 1
            self.changeView()
        }
    }
}


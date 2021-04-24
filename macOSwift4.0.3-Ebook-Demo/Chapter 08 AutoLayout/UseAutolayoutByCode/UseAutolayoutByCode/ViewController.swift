//
//  ViewController.swift
//  UseAutolayoutByCode
//
//  Created by iDevFans on 16/9/25.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.addViewConstraint()
        
        self.addConstraintByAnchor()
    }

    func addViewConstraint() {

        let currentView = NSView()
        currentView.wantsLayer = true
        currentView.layer?.backgroundColor = NSColor.blue.cgColor
        self.view.addSubview(currentView)
        currentView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewTop = NSLayoutConstraint(item: currentView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 5)
        
        let viewBottom = NSLayoutConstraint(item: currentView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -5)
        
        let viewLeading = NSLayoutConstraint(item: currentView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 5)
        
        let viewTrailing = NSLayoutConstraint(item: currentView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -5)

        self.view.addConstraint(viewTop)
        self.view.addConstraint(viewBottom)
        self.view.addConstraint(viewLeading)
        self.view.addConstraint(viewTrailing)
    }
    
    
    
    func addConstraintByAnchor() {
        
        let currentView = NSView()
        currentView.wantsLayer = true
        currentView.layer?.backgroundColor = NSColor.blue.cgColor
        self.view.addSubview(currentView)
        currentView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = currentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5)
        let bottom = currentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5)
        
        let left =  currentView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5)
        let right = currentView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5)
      
        self.view.addConstraints([top,bottom,left,right])
        
        //或者使用下面全局方法也可以增进约束
        // NSLayoutConstraint.activate([top,bottom,left,right])
    }
    
    
    

}






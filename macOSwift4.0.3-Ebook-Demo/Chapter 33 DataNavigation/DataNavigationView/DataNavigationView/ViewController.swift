//
//  ViewController.swift
//  DataNavigationView
//
//  Created by iDevFans on 16/8/16.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    //懒加载定义dataNavigationView
    lazy var dataNavigationView: DataNavigationView = {
        let navigationView = DataNavigationView()
        return navigationView
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.dataNavigationView)
        self.dataNavigationView.target = self
        self.dataNavigationView.action = #selector(ViewController.toolButtonClicked(_:))
        self.dataNavigationView.setUpNavigationViewWithItems(self.dataNavigationItemsConfig())
        self.dataNavigationView.updateLabelWithIdentifier("info", title: "30 Records")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAutolayout()
    }
    
    //设置dataNavigationView的自动布局约束
    func setupAutolayout(){
        
        self.dataNavigationView.translatesAutoresizingMaskIntoConstraints = false
        let top = self.dataNavigationView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32)
        let bottom = self.dataNavigationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        
        let left = self.dataNavigationView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0)
        let right = self.dataNavigationView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
    
        //激活自动布局约束
        NSLayoutConstraint.activate([left, right,top, bottom ])
        
    }
    
    //根据不同的tag执行不同的处理
    @objc func toolButtonClicked(_ sender: NSButton) {
        print("button.tag \(sender.tag)")
    }
    
    //导航面板按钮自定义
    func dataNavigationItemsConfig() ->[DataNavigationItem] {
        
        let insertItem = DataNavigationButtonItem()
        insertItem.imageName = NSImage.Name.addTemplate.rawValue
        insertItem.tooltips = "insert a row into current table"
        insertItem.tag = .add
        
        let deleteItem = DataNavigationButtonItem()
        deleteItem.imageName = NSImage.Name.removeTemplate.rawValue
        deleteItem.tooltips = "delete seleted rows form current table"
        deleteItem.tag = .remove
        
        let refreshItem = DataNavigationButtonItem()
        refreshItem.imageName = NSImage.Name.refreshTemplate.rawValue
        refreshItem.tooltips = "reload table data"
        refreshItem.tag = .refresh
        
        let flexibleItem = DataNavigationFlexibleItem()
        
        
        let firstItem = DataNavigationButtonItem()
        firstItem.imageName = kToolbarFirstImageName
        firstItem.tooltips = "go first page"
        firstItem.tag = .first
        
        let preItem = DataNavigationButtonItem()
        preItem.imageName = kToolbarPreImageName
        preItem.tooltips = "go pre page"
        preItem.tag = .pre
        
        let pageLable = DataNavigationTextItem()
        pageLable.identifier = "pages"
        pageLable.title = "0/0"
        pageLable.alignment = .center
  
       
        let nextItem = DataNavigationButtonItem()
        nextItem.imageName = kToolbarNextImageName
        nextItem.tooltips = "go next page"
        nextItem.tag = .next
        
        let lastItem = DataNavigationButtonItem()
        lastItem.imageName = kToolbarLastImageName
        lastItem.tooltips = "go last page"
        lastItem.tag = .last
        

        return [insertItem,deleteItem,refreshItem,flexibleItem,firstItem,preItem,pageLable,nextItem,lastItem]
        
    }

}





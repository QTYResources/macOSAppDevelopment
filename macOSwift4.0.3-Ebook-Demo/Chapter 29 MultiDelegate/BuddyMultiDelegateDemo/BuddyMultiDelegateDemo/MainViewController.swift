//
//  MainViewController.swift
//  BuddyMultiDelegateDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class MainViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configConstraints()
    }
    
    func configConstraints() {
        
        let controllers = self.childViewControllers;
        
        if controllers.count < 2 {
            return
        }
        
        let leftVC = controllers[0]
        
        let rightVC = controllers[1]
        
        //设置左边视图的宽度最小100,最大300
        leftVC.view.width >= 100
        leftVC.view.width <= 260
        
        //设置右边视图的宽度最小300,最大2000
        rightVC.view.width >= 300
        rightVC.view.width <= 2000
    }
    
}

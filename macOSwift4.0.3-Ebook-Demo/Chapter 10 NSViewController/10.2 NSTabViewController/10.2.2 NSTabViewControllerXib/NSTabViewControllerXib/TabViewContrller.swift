//
//  TabViewContrller.swift
//  NSTabViewControllerXib
//
//  Created by iDevFans on 16/7/18.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class TabViewContrller: NSTabViewController   {

    override func viewDidLoad() {
        
        
       
        
        let firstViewController  = FirstViewController()
        firstViewController.title =  "FirstTab";
        
        let secondViewController = SecondViewController()
        secondViewController.title = "SecondTab";

        
        self.addChildViewController(firstViewController)
        self.addChildViewController(secondViewController)

    }
}

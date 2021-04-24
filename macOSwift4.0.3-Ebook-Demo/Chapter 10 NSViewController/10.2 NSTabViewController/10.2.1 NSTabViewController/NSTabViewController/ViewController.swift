//
//  ViewController.swift
//  NSTabViewController
//
//  Created by iDevFans on 16/7/18.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tabView: NSTabView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabItems = self.tabView.tabViewItems
        let vc1 = FirstViewController()
        let vc2 = SecondViewController()
        let vcs = [vc1,vc2]
        var index = 0
        for item in tabItems  {
            let vc = vcs[index]
            item.view?.addSubview(vc.view)
            vc.view.frame = item.view!.bounds
            index = index+1
        }
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}






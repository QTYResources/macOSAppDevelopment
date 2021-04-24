//
//  ViewController.swift
//  ChangeView
//
//  Created by iDevFans on 16/7/15.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var mainView: NSView!
    
    var currentController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateControllers()
        self.changeViewController(0)
        
        
    }


    func initiateControllers() {
        let vc1 = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "FirstVC")) as! NSViewController
        let vc2 = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "SecondVC")) as! NSViewController
        self.addChildViewController(vc1)
        self.addChildViewController(vc2)
    }
    
    
    //通过ComboBox选择，切换到不同的视图控制器显示内容
    
    @IBAction func selectionChanged(_ sender: NSComboBox) {
        let selectedIndex = sender.indexOfSelectedItem
        self.changeViewController(selectedIndex)
        
    }
   

    func changeViewController(_ index: NSInteger) {
        if currentController != nil {
            currentController?.view.removeFromSuperview()
        }
        //数组越界保护
        guard index >= 0  &&  index <= self.childViewControllers.count-1 else {
            return
        }
        
        currentController = self.childViewControllers[index]
        self.mainView.addSubview((currentController?.view)!)
        
        //autoLayout约束
        let topAnchor = currentController?.view.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 0)

        let bottomAnchor = currentController?.view.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 0)
        
        
        let leftAnchor =  currentController?.view.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 0)
        
        let rightAnchor = currentController?.view.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: 0)
        
        NSLayoutConstraint.activate([topAnchor!, bottomAnchor!, leftAnchor!, rightAnchor!])
        
    }
   
}


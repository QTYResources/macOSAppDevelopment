//
//  ViewController.swift
//  RunLoopiOS
//
//  Created by iDevFans on 16/10/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let timer = Timer(timeInterval: 0.2, target: self, selector: #selector(self.doFireTimer), userInfo: "ya了个hoo", repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    @objc func doFireTimer(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


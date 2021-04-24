//
//  NSConditionTest.swift
//  Thread
//
//  Created by iDevFans on 16/10/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class NSConditionTest: NSObject {
    
    var completed = false
    
    lazy var condition:  NSCondition = {
        let c = NSCondition()
        return c
    }()
    
    func clearCondition() {
        self.completed = false
    }
    
    @objc func doWork1() {
        print("doWork1 Begin")
        self.condition.lock()
        while !self.completed {
            self.condition.wait()
        }
        print("doWork1 End")
        self.condition.unlock()
    }
    
    @objc func doWork2() {
        print("doWork2 Begin")
        //do some work
        self.condition.lock()
        self.completed = true
        self.condition.signal()
        self.condition.unlock()
        print("doWork2 End")
    }
    
    func doWork() {
        self.performSelector(inBackground: #selector(self.doWork1), with: nil)
        self.perform(#selector(self.doWork2), with: nil, afterDelay: 0.1)
    }
   
}

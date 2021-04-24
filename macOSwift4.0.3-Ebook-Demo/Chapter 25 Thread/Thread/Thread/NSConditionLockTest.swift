//
//  NSConditionLockTest.swift
//  Thread
//
//  Created by iDevFans on 16/10/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class NSConditionLockTest: NSObject {

    lazy var condition:  NSConditionLock = {
        let c = NSConditionLock()
        return c
    }()
    
    var queue = [String]()
    
    @objc func doWork1() {
        print("doWork1 Begin")
        while true {
            sleep(1)
            self.condition.lock()
            print("doWork1 ")
            self.queue.append("A1")
            self.queue.append("A2")
            self.condition.unlock(withCondition: 2)
        }
        print("doWork1 End")
    }
    
    @objc func doWork2() {
        print("doWork2 Begin")
        while true {
            sleep(1)
            self.condition.lock(whenCondition: 2)
            print("doWork2 ")
            self.queue.removeAll()
            self.condition.unlock()
        }
        print("doWork2 End")
    }
    
    func doWork() {
        self.performSelector(inBackground: #selector(self.doWork1), with: nil)
        self.perform(#selector(self.doWork2), with: nil, afterDelay: 0.1)
    }
}

//
//  ViewController.swift
//  Thread
//
//  Created by iDevFans on 16/10/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testClass = MyTestClass()
        
        //testClass.startThread()
        
        //testClass.createThread()
        
        let conditionLockTest = NSConditionLockTest()
        
       // conditionLockTest.doWork()
        
        
        
        let conditionTest = NSConditionTest()
        
        conditionTest.doWork()
        

    }
    
    
    
    func atomicLock(){
        
        let count = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
        
        count.pointee = 2
        
        OSAtomicIncrement32(count)
        
        print("val=\(count.pointee )")
        
        OSAtomicDecrement32(count)
        
        print("val=\(count.pointee )")
    }
    
    
    func nsLock(){
        
        let lock = NSLock()
        
        if lock.try() {
            
            //Do some work
            
            lock.unlock()
        }
    }
   
    
    func recursiveLock(){
        
        let theLock = NSRecursiveLock()
        for i in 0..<10 {
            theLock.lock()
            //Do some work
            theLock.unlock()
        }
        
    }
    

}








class MyTestClass: NSObject {
    
    func startThread() {
        Thread.detachNewThreadSelector(#selector(self.computerSum), toTarget: self, with: nil)
    }
    
    @objc func computerSum() {
        var sum = 0
        for i in 0..<10 {
            sum += i
        }
        print("sum = \(sum)")
    }

    func createThread() {
        let thread = Thread(target: self, selector: #selector(self.computerSum), object: nil)
        thread.name = "Thread1"
        thread.start()
        
        thread.perform( #selector(self.computerSum), with: nil, afterDelay: 10, inModes: [])
        
        
    }
    
}




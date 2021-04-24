//
//  ViewController.swift
//  GCD
//
//  Created by iDevFans on 16/9/29.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


class MyObject: NSObject {
    private var internalState: Int
    private let queue: DispatchQueue
    
    var semaphore = DispatchSemaphore(value: 0)
    
    override init() {
        internalState = 0
        queue = DispatchQueue(label: "macdev.io.exam")
        
        super.init()
        
        let key = DispatchSpecificKey<Void>()
        queue.setSpecific(key:key, value:())
        
    }
    var state: Int {
        get {
            
            return queue.sync { internalState }
        }
        set (newState) {
            queue.sync{ internalState = newState }
        }
    }
    
    
    func suspendQueue() {
        queue.suspend()
    }
    
    func resumeQueue() {
        queue.resume()
    }
    
   
}





class ViewController: NSViewController {

    var interface: String?
    
    var key = DispatchSpecificKey<Void>()
    
    lazy var queue: DispatchQueue = {
        let queue = DispatchQueue(label: "macdev.io.exam")
        queue.setSpecific(key:self.key, value:())
        return queue
    }()
    
    
    func readInterface() -> String? {
        var result: String?
        if (DispatchQueue.getSpecific(key: self.key) != nil) {
            return self.interface
        }
        self.queue.sync {
            result = self.interface
        }
        return result
    }
    
    func updateInterface(_ newInterface: String?)  {
        let value = newInterface
        self.queue.async {
            self.interface = value
        }
    }
    
    var semaphore = DispatchSemaphore(value: 10)
    
    
    @IBAction func waitAction(_ sender: AnyObject) {
        self.queue.async {
            self.semaphore.wait()
            print("begin work!")
        }
    }
    
    @IBAction func signalAction(_ sender: AnyObject) {
        semaphore.signal()
    }
    
    
    @IBAction func readAction(_ sender: AnyObject) {
        
        let v = self.readInterface()
        
        print("v = \(v)")
        
        self.queue.sync {
            let  result = self.readInterface()
            print("result = \(result)")
        }
    }
    
    @IBAction func writeAction(_ sender: AnyObject) {
        
        
        self.updateInterface( "123")
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //需要测试那个功能 可以去掉下面的注释
        
        //asyncTask()
        
        //syncTask()
        
        //groupTask()
        
        //groupWaitTask()
        
        //groupEnterLeaveTask()
        
        //apply()
        
        barrierTask()
    }
    
    
    func createQueue() {
        
        let queue1 = DispatchQueue(label: "macdev.io.exam")
        
        let queue2 = DispatchQueue(label: "myBackgroundQueue", qos: .userInitiated, attributes: .concurrent)
        
        let queue3 = DispatchQueue.main
        
        let queue4 = DispatchQueue.global(qos: .userInitiated)
    }
    
    func asyncTask() {
        let queue = DispatchQueue(label: "macdev.io.exam")
        queue.async {
            print("Do some tasks!")
        }
        print("The tasks may or may not have run!")
    }
    
    
    func syncTask() {
        let queue = DispatchQueue(label: "macdev.io.exam")
        
        queue.sync {
            print("Do some work 1 here!")
        }
        
        queue.sync {
            print("Do some work 2 here!")
        }
        
        print("All  works have completed!")
    }
    
    func backSwitchMain() {
        
        let queue = DispatchQueue(label: "macdev.io.exam")
        
        queue.async {
            var sum = 0
            for i in 1...10  {
                sum += i
            }
        
            let textFiled = NSTextField()
            DispatchQueue.main.async {
                // 更新计算结果到UI
                textFiled.integerValue = sum
            }
        }
    }
    
   
    
    func groupTask() {
        
        let group = DispatchGroup()
        
        let queue = DispatchQueue(label: "macdev.io.exam")
        
        queue.async(group:group) {
            print("Do some work 1 here")
        }
        
        queue.async(group:group) {
            print("Do some work 2 here")
        }
        
        let workItem = DispatchWorkItem(qos: .userInitiated, flags: .assignCurrentContext) {
            print("group complete")
        }
        
        group.notify(queue: queue, work: workItem)
        
    }
    
    
    func groupWaitTask() {
        
        let group = DispatchGroup()
        
        let queue = DispatchQueue(label: "macdev.io.exam")
        
        queue.async(group:group) {
            print("Do some work 1 here")
        }
        
        queue.async(group:group) {
            print("Do some work 2 here")
        }
        
        let workItem = DispatchWorkItem(qos: .userInitiated, flags: .assignCurrentContext) {
            print("group complete")
        }
        
        group.notify(queue: queue, work: workItem)
        
        _ = group.wait()
        print("Do some work 3 here")

    }

    
    let   kServerBaseUrl = "http://www.iosxhelper.com/SAPI"

    func groupEnterLeaveTask() {
        
        let group = DispatchGroup()
        
        let httpClient = HTTPClient()
        let urlString = "\(kServerBaseUrl)\("/VersionCheck")"
        let url = URL(string: urlString)
        
        group.enter()
        httpClient.get(url!, parameters: nil, success: {(responseObject: Any?) -> Void in
               print("first get data =\(responseObject!) ")
               group.leave()
            }, failure: {(error: Error?) -> Void in
        })
        
        group.enter()
        httpClient.get(url!, parameters: nil, success: {(responseObject: Any?) -> Void in
               print("second get data =\(responseObject!) ")
               group.leave()
            }, failure: {(error: Error?) -> Void in
        })
        
        let workItem = DispatchWorkItem(qos: .userInitiated, flags: .assignCurrentContext) {
            print("group complete")
        }
        group.notify(queue: DispatchQueue.main, work: workItem)
    }
    
    func apply(){
        DispatchQueue.concurrentPerform(iterations: 2) {
            i in
            print("\(i)")
        }
    }
    
    
    func delayTask() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            print("Do some work after 3s !")
        }
    }
    
    
    func barrierTask() {
        
        let queue = DispatchQueue(label: "myBackgroundQueue", qos: .userInitiated, attributes: .concurrent)
        
        queue.async {
            print("Do some work 1 here!")
        }
        
        queue.async {
            print("Do some work 2 here")
        }
        
        queue.async {
            print("Do some work 3 here")
        }
        
        queue.async(flags:.barrier){
            print("Do some work 4 here")
        }
        
        queue.async {
            print("Do some work 5 here")
        }
    }
    
}





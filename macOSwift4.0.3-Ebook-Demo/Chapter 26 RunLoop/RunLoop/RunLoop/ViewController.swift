//
//  ViewController.swift
//  RunLoop
//
//  Created by iDevFans on 16/10/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var timeLabel: NSTextField!
    var timer: Timer?
    var timeCount: Int32 = 100

    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer(timeInterval: 0.5, target: self, selector: #selector(self.doFireTimer), userInfo: nil, repeats: true)
        
        //RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)

        //self.addRunLoopObserver()
        
        
        self.gcdTimerTest()
    }

    
    @objc func doFireTimer(){
        if timeCount <= 0 {
            return
        }
        timeCount -= 1
        self.timeLabel.intValue = timeCount
    }
    
    var gcdTimer: DispatchSourceTimer?
    func gcdTimerTest(){
        gcdTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        gcdTimer?.setEventHandler(handler: {
            //定时器事件
            print("timer out")
        })
        //配置为重复执行的定时器
        gcdTimer?.scheduleRepeating(deadline: .now() + 1, interval: 1)
        //gcdTimer?.scheduleOneshot(deadline: .now() + 1)   单次定时器
        
        //启动定时器，取消为 cancel,挂起为 suspend
        gcdTimer?.resume()
        
    }

    
    func addRunLoopObserver(){
        var _self = self
        //定义 Observer 的 Context
        var observerContext = CFRunLoopObserverContext(version: 0, info: &_self, retain: nil, release: nil, copyDescription: nil)
        //创建 Observer
        let observer = CFRunLoopObserverCreate(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, self.observerCallbackFunc(), &observerContext)
        if(observer != nil) {
            //增加当前线程 RunLoop Observer
            CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, CFRunLoopMode.defaultMode)
        }
    }
    
    //Observer 的状态回调函数
    func observerCallbackFunc() -> CFRunLoopObserverCallBack {
        
        return {(observer, activity, context) -> Void in
            
            switch(activity) {
                
            case CFRunLoopActivity.entry:
                print("Run Loop Entry")
                break
            case CFRunLoopActivity.beforeTimers:
                print("Run Loop BeforeTimers")
                break
            case CFRunLoopActivity.beforeSources:
                print("Run Loop BeforeSources")
                break
            case CFRunLoopActivity.beforeWaiting:
                print("Run Loop BeforeWaiting")
                break
            case CFRunLoopActivity.afterWaiting:
                print("Run Loop AfterWaiting")
                break
            case CFRunLoopActivity.exit:
                print("Run Loop Exit")
                break
            default:
                break
                
            }
        }
    }
}



var gcdTimer: DispatchSourceTimer?
func gcdTimerTest(){
    gcdTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
    gcdTimer?.setEventHandler(handler: {
        //定时器事件
        print("timer out")
    })
    //配置为重复执行的定时器
    gcdTimer?.scheduleRepeating(deadline: .now() + 1, interval: 1)
    //gcdTimer?.scheduleOneshot(deadline: .now() + 1)   单次定时器
    
    //启动定时器，取消为 cancel,挂起为 suspend
    gcdTimer?.resume()
    
}

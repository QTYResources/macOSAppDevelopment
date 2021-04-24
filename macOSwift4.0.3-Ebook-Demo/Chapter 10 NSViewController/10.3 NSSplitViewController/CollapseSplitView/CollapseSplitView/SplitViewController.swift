//
//  SplitViewController.swift
//  NSSplitViewCollapse
//
//  Created by iDevFans on 16/7/20.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    
    var isLeftCollapsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(self.toggleLeftView(_:)),  name:NSNotification.Name.onOpenCloseView, object: nil)
    }
    
    @objc func toggleLeftView2(_ notification: Notification){
         let isCollapsed = self.splitViewItems.first!.animator().isCollapsed
         self.splitViewItems.first!.animator().isCollapsed = !isCollapsed
    }
    
    @objc func toggleLeftView(_ notification: Notification){
        if isLeftCollapsed {
            self.expandLeftView()
            isLeftCollapsed = false
        }
        else {
            self.collapsedLeftView()
            isLeftCollapsed = true
        }
    }
    
    func expandLeftView(){
        
        let leftView = self.splitView.subviews[0]
        let rightView = self.splitView.subviews[1]
        leftView.isHidden = false
        
        let dividerThickness = self.splitView.dividerThickness
        
        let leftFrame = leftView.frame
        var rightFrame = rightView.frame
        
        //右边视图frame 恢复到之前的大小(rightView.size = splitView.size - leftView.size)
        rightFrame.size.width = rightFrame.size.width - leftFrame.size.width - dividerThickness
        
        rightView.frame = rightFrame
        //重新刷新显示
        self.splitView.display()
    }
    
    func collapsedLeftView(){
        let leftView = self.splitView.subviews[0]
        let rightView = self.splitView.subviews[1]
        //隐藏左边视图
        leftView.isHidden = true
        
        var frame = rightView.frame
        frame.size = self.splitView.frame.size
        //右边视图frame 占据整个 splitview 的大小
        rightView.frame = frame;
        //重新刷新显示
        self.splitView.display()
    }
}

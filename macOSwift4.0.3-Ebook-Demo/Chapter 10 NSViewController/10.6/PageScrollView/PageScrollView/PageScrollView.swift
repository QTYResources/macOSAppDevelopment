//
//  PageScrollView.swift
//  PageCollectionImageViewer
//
//  Created by iDevFans on 2017/5/25.
//  Copyright © 2017年 macdev. All rights reserved.
//

import Cocoa

protocol PageScrollViewDelegate: NSObjectProtocol {
    func scroll(to currentPage: Int , pageScrollView: PageScrollView)
    func numberOfPages(in pageScrollView: PageScrollView) -> Int
    func itemPadding(in pageScrollView: PageScrollView) -> CGFloat
}

class PageScrollView: NSScrollView {
    
    weak var delegate: PageScrollViewDelegate?
    var currentPage:Int = 0
    var scrollThreshold: CGFloat = 20
    
    var numberOfPages: Int {
        if let delegate = delegate {
           let numberOfPages = delegate.numberOfPages(in: self)
           return numberOfPages
        }
        return 0
    }
    
    var itemPaddding: CGFloat {
        if let delegate = delegate {
            let padding = delegate.itemPadding(in: self)
            return padding
        }
        return 10
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        registerNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerNotifications()
    }
    
    func registerNotifications(){
        NotificationCenter.default.addObserver(self, selector:#selector(self.recieveEndLiveScrollNotification(_:)),  name:NSScrollView.didEndLiveScrollNotification, object: self)
    }

    override func tile() {
        super.tile()
        var f = self.horizontalScroller?.frame
        f?.size.height = 0
        self.horizontalScroller?.frame = f!
        
        var v = self.verticalScroller?.frame
        v?.size.width = 0
        self.verticalScroller?.frame = v!
    }
    
    func scrollPrePage(){
        if currentPage == 0 {
            return
        }
        scroll(to:currentPage - 1)
    }
    
    func scrollNextPage(){
        if currentPage >= numberOfPages {
            return
        }
        scroll(to:currentPage + 1)
    }
    
    func scroll(to page:Int) {
        
        guard page >= 0 && page < numberOfPages, currentPage != page   else {
            return
        }
        currentPage = page
        
        var newOrigin = NSPoint(x: self.contentSize.width * CGFloat(currentPage) - CGFloat(currentPage) * itemPaddding, y: 0)
        
        if !NSPointInRect(newOrigin, (self.documentView?.frame)!) {
            return
        }
        
        let maxDx = NSMaxX(self.documentView!.frame) - self.contentSize.width
        if newOrigin.x > maxDx {
            newOrigin.x = maxDx
        }
        if newOrigin.x < 0 {
            newOrigin.x = 0
        }
        
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 1
        self.contentView.animator().setBoundsOrigin(newOrigin)
        NSAnimationContext.endGrouping()
    
        if let delegate = delegate {
            delegate.scroll(to: currentPage, pageScrollView: self)
        }
    }


    @objc func recieveEndLiveScrollNotification(_ notification: Notification){
        let currentRect = NSRect(x: self.contentSize.width * CGFloat(currentPage), y: 0, width: self.contentSize.width, height: self.contentSize.height)
        let dx =   self.documentVisibleRect.origin.x  - currentRect.origin.x
        if abs (dx) > scrollThreshold  {
            var newPage: Int
            if dx > 0 {
                newPage = Int(NSMaxX(self.documentVisibleRect) / self.contentSize.width)
                if newPage >= numberOfPages {
                    newPage = numberOfPages - 1
                }
            }
            else {
                newPage = Int(NSMinX(self.documentVisibleRect) / self.contentSize.width)
                if newPage < 0 {
                    newPage = 0
                }
            }
            scroll(to: newPage)
        }
    }
}

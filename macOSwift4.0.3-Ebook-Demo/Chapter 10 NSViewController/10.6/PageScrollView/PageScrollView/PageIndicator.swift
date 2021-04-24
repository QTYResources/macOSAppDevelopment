//
//  PageIndicator.swift
//  CollectionImageViewer
//
//  Created by zhaojw on 27/05/2017.
//  Copyright © 2017 macdev. All rights reserved.
//

import Cocoa

protocol PageIndicatorDelegate: NSObjectProtocol {
    func pageIndicator(pageIndicator: PageIndicator , didSelectPageAtIndex: Int)
}

class PageIndicator: NSView {
    weak var delegate: PageIndicatorDelegate?
    var selectedColor: NSColor? = NSColor.gray
    var normalColor: NSColor? = NSColor.gray.withAlphaComponent(0.5)
    
    var indicatorMargin: CGFloat = 8.0 {
        didSet {
            needsDisplay = true
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            needsDisplay = true
            if let delegate = delegate {
                delegate.pageIndicator(pageIndicator: self, didSelectPageAtIndex: currentPage)
            }
        }
    }
    
    var numberOfPages: Int = 0 {
        didSet {
            needsDisplay = true
        }
    }
    
    var pageIndicatorSize: NSSize = NSSize(width: 6, height: 6) {
        didSet {
            needsDisplay = true
        }
    }
    
    var indicatorRects: [NSRect] =  [NSRect]()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let indicatorAreaWidth = pageIndicatorSize.width * CGFloat(numberOfPages) + indicatorMargin * CGFloat( numberOfPages - 1)
        var leftPosiont: CGFloat = (self.bounds.size.width - indicatorAreaWidth) / 2
        let topPadding: CGFloat  = (self.bounds.size.height - pageIndicatorSize.height) / 2
        
        indicatorRects.removeAll()
        
        for i in 0 ..< numberOfPages {
            let position = NSPoint(x: leftPosiont, y: topPadding)
            let rect = NSRect(origin: position, size: pageIndicatorSize)
            indicatorRects.append(rect)
            let indicatorPath = NSBezierPath(ovalIn: rect)
            if currentPage == i {
                selectedColor?.setFill()
            }
            else {
                normalColor?.setFill()
            }
            indicatorPath.fill()
            leftPosiont += (pageIndicatorSize.width + indicatorMargin)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        let eventLocation = event.locationInWindow
        //转化成视图的本地坐标
        let pointInView    = self.convert(eventLocation, from: nil)
        for i in 0 ..< numberOfPages {
            let rect = indicatorRects[i].insetBy(dx: -2, dy: -2)
            if NSPointInRect(pointInView, rect) {
                currentPage = i
                break
            }
        }
    }
}

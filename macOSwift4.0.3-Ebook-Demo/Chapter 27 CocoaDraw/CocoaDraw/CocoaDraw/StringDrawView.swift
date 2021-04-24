//
//  StringDrawView.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class StringDrawView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        //self.drawString()
        
        self.drawAttributedString()
    
    }
    
    func allDrawObjects()->[DrawObject] {
       return [DrawObject]()
    }
    
    func drawString(){
        
        let str: NSString = "RoundedRect"
        let font = NSFont(name: "Palatino-Roman", size: 14.0)
        var attrsDictionary = [NSAttributedStringKey: Any]()
        attrsDictionary[NSAttributedStringKey.font] = font
        attrsDictionary[NSAttributedStringKey.foregroundColor] =  NSColor.green
        let p = CGPoint(x: 0, y: 0)
        str.draw(at: p, withAttributes: attrsDictionary)
        
    }
    
    func drawAttributedString(){

        let content = "NSMutableAttributedString"
        let string = NSMutableAttributedString(string: content)
        let p = CGPoint(x: 0, y: 10)
        let selectedRange = NSRange(location: 0, length: content.characters.count)
        
        let linkURL = NSURL(string: "http://www.youtube.com/")!
        string.addAttribute(NSAttributedStringKey.link, value: linkURL, range: selectedRange)
        string.addAttribute(NSAttributedStringKey.foregroundColor, value: NSColor.blue, range: selectedRange)
        
        string.draw(at: p)
    }
    
    func drawObject(){
        
        let drawObjects = self.allDrawObjects()
        
        var rects = UnsafePointer<NSRect>.init(bitPattern: 1)
        var count = Int.init()
        
        self.getRectsBeingDrawn(&rects, count: &count)
        
        for drawObject in drawObjects {
            for i in 0..<count {
                if NSIntersectsRect(drawObject.bounds, (rects?[i])!) {
                    drawObject.draw()
                }
            }
        }
    }
    
}





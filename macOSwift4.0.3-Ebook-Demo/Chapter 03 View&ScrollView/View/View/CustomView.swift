//
//  CustomView.swift
//  View
//
//  Created by iDevFans on 16/6/25.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Foundation
import AppKit

final class CustomView: NSView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configLayer()
    }
    
    override var isFlipped: Bool {
        get {
            return true
        }
    }
    
    // MARK: Event
    override func mouseDown(with theEvent: NSEvent) {
        let point = self.convert(theEvent.locationInWindow, to: nil)
        NSLog("window point: \(theEvent.locationInWindow)")
        NSLog("view point: \(point)")
    }
    
    func configLayer(){
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.red.cgColor
        self.layer?.borderWidth = 2
        self.layer?.cornerRadius = 10
    }
    
    // MARK :  Draw
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.blue.setFill()
        let frame = self.bounds
        let path = NSBezierPath()
        path .appendRoundedRect(frame, xRadius: 20, yRadius: 20)
        path.fill()
    }
    
    func drawViewShape(){
        self.lockFocus()
        //NSRectFill(self.bounds)
        let text: NSString = "RoundedRect"
        let font = NSFont(name: "Palatino-Roman", size: 12)
        let attrs = [NSAttributedStringKey.font :font! ,
                        NSAttributedStringKey.foregroundColor :NSColor.blue,NSAttributedStringKey.backgroundColor :NSColor.red]
        let loaction = NSPoint(x: 50, y: 50)
        text.draw(at: loaction, withAttributes: attrs)
        self.unlockFocus()
    }
    
    func saveScrollViewAsImage() {
        let pdfData = self.dataWithPDF(inside: self.bounds)
        let imageRep = NSPDFImageRep(data: pdfData)!
        let count = imageRep.pageCount
        for i in 0..<count {
            imageRep.currentPage = i
            let tempImage = NSImage()
            tempImage.addRepresentation(imageRep)
            let rep  = NSBitmapImageRep(data:tempImage.tiffRepresentation!)
            let imageData = rep?.representation(using:.png, properties: [:])
            let fileManager = FileManager.default
            //写死的文件路径
            let path = "/Users/idevfans/Documents/myCapture.png"
            fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
            
            //定位文件路径
            let fileURL = URL(fileURLWithPath: path)
            NSWorkspace.shared.activateFileViewerSelecting([fileURL])
        }
    }
    
    func saveSelfAsImage() {
        self.lockFocus()
        let image = NSImage(data:self.dataWithPDF(inside: self.bounds))
        self.unlockFocus()
        let imageData = image!.tiffRepresentation
        
        let fileManager = FileManager.default
        //写死的文件路径
        let path = "/Users/idevfans/Documents/myCapture.png"
        fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
        
        //定位文件路径
        let fileURL = URL(fileURLWithPath: path)
        NSWorkspace.shared.activateFileViewerSelecting([fileURL])
    }
}






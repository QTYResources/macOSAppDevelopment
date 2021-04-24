//
//  NSScreen+Ext.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/3.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

import Cocoa
import Foundation

extension NSScreen {

    func flipPoint(aPoint: CGPoint) -> CGPoint {
        return CGPoint(x: aPoint.x, y: self.frame.size.height - aPoint.y)
    }
    
    func convertToScreenFromLocalPoint(point: CGPoint, relativeToView view: NSView) -> NSPoint {
        let winP = view.convert(point, to: nil)
        let winRect = CGRect(origin: winP, size: CGSize(width: 10, height: 10))
        let scrnP = view.window!.convertToScreen(winRect).origin
        var flipScrnP = self.flipPoint(aPoint: scrnP)
        flipScrnP.y += self.frame.origin.y
        return flipScrnP
    }
}

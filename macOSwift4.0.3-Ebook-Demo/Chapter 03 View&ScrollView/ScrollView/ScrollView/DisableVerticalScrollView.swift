//
//  DisableVerticalScrollView.swift
//  ScrollView
//
//  Created by iDevFans on 16/10/18.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class DisableVerticalScrollView: NSScrollView {
    override func scrollWheel(with event: NSEvent) {
        let f = abs(event.deltaY)
        if event.deltaX == 0.0 && f >= 0.01  {
            return
        }
        if event.deltaX == 0.0 && f == 0.0  {
            return
        }
        else {
            super.scrollWheel(with: event)
        }
    }
}

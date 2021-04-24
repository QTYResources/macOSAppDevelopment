//
//  NoScrollerScrollView.swift
//  AppX
//
//  Created by zhaojw on 2017/8/27.
//  Copyright © 2017年 macdev. All rights reserved.
//

import Cocoa

class NoScrollerScrollView: NSScrollView {

    override func tile() {
        super.tile()
        var hFrame = self.horizontalScroller?.frame
        hFrame?.size.height = 0
        if let hFrame = hFrame {
            self.horizontalScroller?.frame = hFrame
        }
        
        var vFrame = self.verticalScroller?.frame
        vFrame?.size.width = 0
        if let vFrame = vFrame {
            self.verticalScroller?.frame = vFrame
        }
    }
    
}

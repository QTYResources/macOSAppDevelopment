//
//  ButtonView.swift
//  autoLayoutTips
//
//  Created by iDevFans on 2016/12/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ButtonView: NSView {

    var viewSize: NSSize = NSSize(width: 0, height: 0)
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewSize = self.frame.size
    }

    override var intrinsicContentSize: NSSize {
        return self.viewSize
    }
}

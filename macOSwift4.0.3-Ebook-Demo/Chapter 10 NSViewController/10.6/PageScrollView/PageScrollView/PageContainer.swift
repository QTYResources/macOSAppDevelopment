//
//  PageContainer.swift
//  PageScrollView
//
//  Created by zhaojw on 2017/11/11.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

class PageContainer: NSView {
    var viewSize: NSSize = NSSize(width: 0, height: 0)
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewSize = self.frame.size
    }
    override var intrinsicContentSize: NSSize {
        return self.viewSize
    }
}

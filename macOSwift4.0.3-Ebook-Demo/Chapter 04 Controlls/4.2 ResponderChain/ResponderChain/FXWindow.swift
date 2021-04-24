//
//  FXWindow.swift
//  ResponderChain
//
//  Created by iDevFans on 16/6/27.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Foundation
import AppKit

class FXWindow: NSWindow {
    override func scrollWheel(with event: NSEvent) {
        NSLog("scrollWheel \(self)")
    }
}



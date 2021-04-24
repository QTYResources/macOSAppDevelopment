//
//  OutlineView.swift
//  NSOutlineView
//
//  Created by iDevFans on 2016/11/16.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa


class OutlineView: NSOutlineView {

    override func makeView(withIdentifier identifier: NSUserInterfaceItemIdentifier, owner: Any?) -> NSView?{
        let view = super.makeView(withIdentifier: identifier, owner: owner)
        if (identifier == NSOutlineView.disclosureButtonIdentifier) {
            let button:NSButton = view as! NSButton
            button.image = NSImage(named: NSImage.Name(rawValue: "Plus"))!
            button.alternateImage = NSImage(named: NSImage.Name(rawValue: "Minus"))!
            button.isBordered = false
            button.title = ""
            return button
        }
        return view
    }
    
    
    weak var nodeMenu: NSMenu?

    override func menu(for event: NSEvent) -> NSMenu? {
        let pt = self.convert(event.locationInWindow, from: nil)
        let row = self.row(at: pt)
        if row >= 0 {
            return self.nodeMenu
        }
        return super.menu(for: event)!
    }
}


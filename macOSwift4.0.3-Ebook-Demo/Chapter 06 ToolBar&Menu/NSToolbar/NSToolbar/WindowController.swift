//
//  WindowController.swift
//  NSToolbar
//
//  Created by iDevFans on 16/7/8.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

extension NSToolbar.Identifier {
    public static let AppToolbar: NSToolbar.Identifier =  NSToolbar.Identifier(rawValue: "AppToolbar")
}

extension NSToolbarItem.Identifier {
    public static let FontSetting: NSToolbarItem.Identifier =  NSToolbarItem.Identifier(rawValue: "FontSetting")
    public static let Save: NSToolbarItem.Identifier =  NSToolbarItem.Identifier(rawValue: "Save")
}

extension  NSImage.Name {
    public static let FontSetting:  NSImage.Name =   NSImage.Name(rawValue: "FontSetting")
    public static let Save:  NSImage.Name =   NSImage.Name(rawValue: "Save")
}

class WindowController: NSWindowController  {

    @IBOutlet weak var toolBar: NSToolbar!
    override func windowDidLoad() {
        super.windowDidLoad()
        //self.setUpToolbar()
        
        self.window?.titleVisibility = .hidden
        //self.window?.styleMask = [.unifiedTitleAndToolbar,.closable,.resizable,.miniaturizable,.titled]
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    
    @IBAction func toolbarItemClicked(_ sender:NSToolbarItem) {
        let tag = sender.tag
        switch tag {
        case 0:  print("0")
        case 1:  print("1")
        default:
               print("1000")
        }
    }
    
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        if item.label == "Open" {
           // return false
        }
        
        if item.label == "Colors" {
            return false
        }
        
        return true
    }
    
    func setUpToolbar(){
        let toolbar = NSToolbar(identifier: NSToolbar.Identifier.AppToolbar)
        toolbar.allowsUserCustomization = false
        toolbar.autosavesConfiguration = false
        toolbar.displayMode = .iconAndLabel
        toolbar.delegate = self
        self.window?.toolbar = toolbar
    }
    
}

extension WindowController: NSToolbarDelegate {
    
    //实际显示的item 标识
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [NSToolbarItem.Identifier.FontSetting,NSToolbarItem.Identifier.Save]
    }
    
    //所有的item 标识,在编辑模式下会显示出所有的item
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
         return [NSToolbarItem.Identifier.FontSetting,NSToolbarItem.Identifier.Save]
    }
    
    //根据item 标识 返回每个具体的NSToolbarItem对象实例
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        if itemIdentifier == NSToolbarItem.Identifier.FontSetting {
            toolbarItem.label = "Font"
            toolbarItem.paletteLabel = "Font"
            toolbarItem.toolTip = "Font Setting"
            toolbarItem.image = NSImage.init(named: NSImage.Name.FontSetting)
            toolbarItem.tag = 1
        }
        
        if itemIdentifier == NSToolbarItem.Identifier.Save {
            toolbarItem.label = "Save"
            toolbarItem.paletteLabel = "Save"
            toolbarItem.toolTip = "Save File"
            toolbarItem.image = NSImage.init(named: NSImage.Name.Save)
            toolbarItem.tag = 2
        }
        
        toolbarItem.minSize = NSSize(width: 25, height: 25)
        toolbarItem.maxSize = NSSize(width: 100, height: 100)
        toolbarItem.target = self
        toolbarItem.action = #selector(WindowController.toolbarItemClicked(_:))
        return toolbarItem
    }
}






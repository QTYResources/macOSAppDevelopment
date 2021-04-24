//
//  AppDelegate.swift
//  NSMenu
//
//  Created by iDevFans on 16/7/9.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var dockMenu: NSMenu!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //self.menuConfig()
        
        self.showSystemMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        return self.dockMenu
    }
    

    func menuConfig() {
        
        let customMenu = NSMenu(title: "MainMenu")
        
    
        let firstLevelMenuItem = NSMenuItem()
        let firstLevelMenu = NSMenu()
        //设置子菜单的2级菜单
        firstLevelMenuItem.submenu = firstLevelMenu


        let aboutMenuItem = NSMenuItem(title: "About",  action:#selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "A")
        
        let preferenceMenuItem = NSMenuItem(title: "Preferences...", action:nil,  keyEquivalent: "P")
        
        let quitMenuItem = NSMenuItem(title: "Quit", action:#selector(NSApplication.terminate(_:)), keyEquivalent: "")
        
        firstLevelMenu.addItem(aboutMenuItem)
        firstLevelMenu.addItem(preferenceMenuItem)
        firstLevelMenu.addItem(quitMenuItem)
        
        
        let secondLevelMenuItem = NSMenuItem()
        let secondLevelMenu = NSMenu(title: "File")
        secondLevelMenuItem.submenu = secondLevelMenu
        
        let openMenuItem = NSMenuItem(title: "Open", action: #selector(AppDelegate.menuClicked(_:)), keyEquivalent: "O")
        openMenuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags.shift
        
        secondLevelMenu.addItem(openMenuItem)
    
        customMenu.addItem(firstLevelMenuItem)
        customMenu.addItem(secondLevelMenuItem)
        
        
        NSApp.mainMenu = customMenu
    }
    
    @IBAction func menuClicked(_ sender: AnyObject) {
        
    }
    
    func showSystemMenu(){
        
        let mainMenu = NSApp.mainMenu
        let subitems = mainMenu?.items
        
        for  menuItem in subitems!  {
            let title = menuItem.title
            
            print("menuItem \(title)")
            let submenu = menuItem.menu
            let subsubitems = submenu?.items
            for subsubitem in subsubitems! {
                print("subsubitem \(subsubitem.title)")
            }
        }
    }
    
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        
        if menuItem.action == #selector(AppDelegate.menuClicked(_:)) {
            return true
        }
        
        return super.validateMenuItem(menuItem)
    }

}












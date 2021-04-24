//
//  WindowController.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/8/27.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let kHomeURL = "http://macdev.io"

public enum ToolbarActionType : Int {
    
    case open
    
    case translate
    
    case export
    
    case help

}


class WindowController: NSWindowController {

    @IBOutlet weak var sourcePopUpButton: NSPopUpButton!
    
    @IBOutlet weak var targetPopUpButton: NSPopUpButton!
    var openDlg = NSOpenPanel()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.openDatabase()
        
        self.configWindowStyle()
        
        self.configView()
    }
    
    
    func openDatabase() {
        
        if !MDatabase.shared.openDBWithName(dbName: dbName) {
            
            print("open Database Failed!")
        }
    }
    
    func configWindowStyle() {
        
        //Toolbar 跟titleBar 融合在一起显示
        self.window?.titleVisibility = .hidden;
        
        //透明化
        self.window?.titlebarAppearsTransparent = true
        //设置背景颜色
        self.window?.backgroundColor = NSColor.toolBarBackgroundColor()
    }
    
    func configView() {
       
        let nations = NationBO.shared.googleNations
        
        self.sourcePopUpButton.removeAllItems()
        self.targetPopUpButton.removeAllItems()
        
        var selectedIndex = 0
        var index = 0
        for nation: Nation in nations! {
            
            let nationStr = "\(nation.name!)(\(nation.code!))"
            if (nation.code == "en") {
                selectedIndex = index
            }
            self.sourcePopUpButton.addItem(withTitle: nationStr)
            self.targetPopUpButton.addItem(withTitle: nationStr)
            index += 1
        }
        self.sourcePopUpButton.selectItem(at: selectedIndex)
        
    }
    
    
    
    @IBAction func toolbarAction(_ sender: NSToolbarItem) {
        
        let actionType = ToolbarActionType(rawValue: sender.tag)!
        
        switch (actionType) {
        case .open:
            openXcodeProject()
            break
        case .translate:
            translate()
            break
        case .export:
            exportAsFile()
            break
        default:
            goHomePage()
            break
        }
        
    }
    
    func openXcodeProject() {
    
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["xcodeproj"]
        
        openDlg.begin(completionHandler: { [weak self] result in
            
            if(result.rawValue == NSFileHandlingPanelOKButton){
                
                let fileURLs = self?.openDlg.urls
                
                for url: URL in fileURLs!  {
                    
                    NotificationCenter.default.post(name:Notification.Name.onOpenXcodeFile, object: url.path)
                    
                    break
                }
            }
        })
    }
    
    func exportAsFile() {
        
    }
    
    func translate() {
        
    }
    
    func goHomePage() {
        
        let url = URL(string: kHomeURL)
        
        if !NSWorkspace.shared.open(url!) {
            print("open failed!")
        }
    }
}

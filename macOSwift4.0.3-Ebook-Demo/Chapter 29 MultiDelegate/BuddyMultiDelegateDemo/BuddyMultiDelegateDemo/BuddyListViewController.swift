//
//  BuddyListViewController.swift
//  BuddyMultiDelegateDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class BuddyListViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    lazy var buddyListDAO: DAO = {
        let dao = BuddyListDAO()
        return dao
    }()
    
    var buddies = [BuddyList]()
    
    deinit {
        unRegisterMultiDelegate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openDB()
        self.registerMultiDelegate()
        self.fetchData()
    }
    
    func openDB(){
        let opened = DataStoreBO.shared.openDefaultDB()
        if opened == false {
            print("openDB Failed!")
        }
    }
    
    func fetchData() {
        DispatchQueue.back.async {
            self.buddies = self.buddyListDAO.findAll() as! [BuddyList]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func upDateBuddyStatus(_ buddy: BuddyList) {
        for aBubby: BuddyList in self.buddies {
            if aBubby.ID == buddy.ID {
                aBubby.status = buddy.status
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension BuddyListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.buddies.count
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        let row = tableView.selectedRow
        if row < 0 || row >= self.buddies.count {
            return
        }
        let buddy = self.buddies[row]
        BuddyStatusManager.shared.multiDelegate.buddySelection(buddy)
    }
}


extension BuddyListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let buddy = self.buddies[row]
        let result = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "buddy"), owner: self)
        let cell = result?.subviews[0] as? NSTextField
        cell?.stringValue = buddy.nickName
        var imageName = "online"
        if !buddy.status {
            imageName = "offline"
        }
        let image = NSImage(named: NSImage.Name(rawValue: imageName))!
        let imageView = result?.subviews[1] as? NSImageView
        imageView?.image = image
        return result
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
}

extension BuddyListViewController: BuddyStatusDelegate {
    
    func registerMultiDelegate() {
        BuddyStatusManager.shared.addMultiDelegate(delegate: self, delegateQueue: nil)
    }
    
    func unRegisterMultiDelegate() {
        BuddyStatusManager.shared.removeMultiDelegate(delegate: self)
    }
    
    func buddyOfflineRequest(sender: AnyObject,  buddy: BuddyList) {
        self.upDateBuddyStatus(buddy)
    }
    
    func buddyOnlineRequest(sender: AnyObject,  buddy: BuddyList) {
         self.upDateBuddyStatus(buddy)
    }
}





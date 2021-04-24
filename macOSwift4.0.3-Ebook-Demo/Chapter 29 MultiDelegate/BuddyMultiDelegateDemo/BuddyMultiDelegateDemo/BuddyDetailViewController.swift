//
//  BuddyDetailViewController.swift
//  BuddyMultiDelegateDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class BuddyDetailViewController: NSViewController {

    @IBOutlet weak var firstNameLabel: NSTextField!
    
    @IBOutlet weak var lastNameLabel: NSTextField!
    
    @IBOutlet weak var addressLabel: NSTextField!
    
    @IBOutlet weak var birthdayLabel: NSTextField!
    
    @IBOutlet weak var idLabel: NSTextField!
    
    @IBOutlet weak var buddyImageView: NSImageView!
    
    
    var buddy: BuddyList?
    var buddyDetail: BuddyDetail?
    
    lazy var buddyDetailDAO: BuddyDetailDAO = {
        let dao = BuddyDetailDAO()
        return dao
    }()
    
    deinit {
        unRegisterMultiDelegate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerMultiDelegate()
    }
    
    
    func updateDetailView() {
        self.idLabel.stringValue = "\(self.buddy!.ID)"
        self.firstNameLabel.stringValue = self.buddyDetail!.firstName
        self.lastNameLabel.stringValue = self.buddyDetail!.lastName
        self.addressLabel.stringValue = self.buddyDetail!.address
        self.birthdayLabel.stringValue = self.buddyDetail!.birthDay
    }
    
    func updateUserImageView() {
        let image = NSImage(named: NSImage.Name(rawValue: self.buddyDetail!.image))
        if self.buddy?.status == false {
            let grayImage = image?.hh_imageTinted(with: NSColor.gray)
            self.buddyImageView.image = grayImage
        }
        else {
            self.buddyImageView.image = image
        }
    }
    
    
    func updateBuddyStutas(_ buddy: BuddyList) {
        if buddy.ID == self.buddy?.ID {
            self.buddy?.status = buddy.status
            self.updateUserImageView()
        }
    }
}


extension BuddyDetailViewController: BuddyStatusDelegate {
    
    func registerMultiDelegate() {
        BuddyStatusManager.shared.addMultiDelegate(delegate: self, delegateQueue: nil)
    }
    
    func unRegisterMultiDelegate() {
        BuddyStatusManager.shared.removeMultiDelegate(delegate: self)
    }
    
    func buddyOfflineRequest(sender: AnyObject,  buddy: BuddyList) {
        self.updateBuddyStutas(buddy)
    }
    
    func buddyOnlineRequest(sender: AnyObject,  buddy: BuddyList) {
        self.updateBuddyStutas(buddy)
    }
    
    func buddySelection(sender: AnyObject,  buddy: BuddyList) {
        
        self.buddy = buddy
        let buddyDetail = self.buddyDetailDAO.findBy(kv: ["ID": buddy.ID]) as? BuddyDetail
        self.buddyDetail = buddyDetail
        self.updateDetailView()
        self.updateUserImageView()
        
    }

    
}


//
//  CollectionViewItem.swift
//  NSCollectionViewCode
//
//  Created by zhaojw on 2017/10/22.
//  Copyright © 2017年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var collImageView: NSImageView!
    @IBOutlet weak var titleField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    
    override var representedObject: Any? {
        didSet {
            
            let data = self.representedObject as! NSDictionary
            
            if let image = data["image"] as? NSImage {
                self.collImageView.image    = image
            }
            if let title = (data["title"] as? String) {
                self.titleField.stringValue = title
            }
        }
    }
    
    
    
}

//
//  CollectionViewItem.swift
//  NSCollectionViewCode
//
//  Created by iDevFans on 16/7/1.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {
   
    @IBOutlet weak var collImageView: NSImageView!
    @IBOutlet weak var titleField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var isSelected: Bool {
        didSet {
            (self.view as! CollectionItemView).selected = isSelected
        }
    }
    
    override var highlightState: NSCollectionViewItem.HighlightState {
        didSet {
            (self.view as! CollectionItemView).highlightState = highlightState
        }
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

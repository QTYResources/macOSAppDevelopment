//
//  CollectionView.swift
//  NSCollectionViewDataSource
//
//  Created by iDevFans on 16/7/5.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class CollectionItemView: NSView {
    
    // MARK: Properties
    
    var selected: Bool = false {
        didSet {
            if selected != oldValue {
                needsDisplay = true
            }
        }
    }
    
    var highlightState: NSCollectionViewItem.HighlightState = .none {
        didSet {
            if highlightState != oldValue {
                needsDisplay = true
            }
        }
    }
    
    // MARK: Layer
    
    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override func updateLayer() {
        if selected {
            //self.layer?.cornerRadius = 10
            layer!.borderColor = NSColor.blue.cgColor
            ;
            layer!.borderWidth = 2
            
        } else {
            //self.layer?.cornerRadius = 0
            layer!.borderColor = NSColor.white.cgColor
            ;
            layer!.borderWidth = 0
        }
    }
    

    // MARK: Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.masksToBounds = true
    }

}

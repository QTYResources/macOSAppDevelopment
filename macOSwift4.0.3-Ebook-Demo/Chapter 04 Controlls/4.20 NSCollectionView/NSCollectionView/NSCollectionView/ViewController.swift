//
//  ViewController.swift
//  NSCollectionView
//
//  Created by iDevFans on 16/6/30.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var collectionView: NSCollectionView!
    
    var content = [NSDictionary]()

    override func viewDidLoad() {
        
        let itemPrototype = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "collectionViewItem"))
            as! NSCollectionViewItem
        
        self.collectionView.itemPrototype = itemPrototype
        
        self.updateContent()
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateContent(){
        
        let item1: NSDictionary = ["title" : "computer","image" : NSImage(named: NSImage.Name.computer)!]
        
        let item2: NSDictionary = ["title" : "folder","image" : NSImage(named: NSImage.Name.folder)!]
        
        let item3: NSDictionary = ["title" : "home","image" : NSImage(named: NSImage.Name.homeTemplate)!]
        
        let item4: NSDictionary = ["title" : "list","image" : NSImage(named: NSImage.Name.listViewTemplate)!]
        
        let item5: NSDictionary = ["title" : "network","image" : NSImage(named: NSImage.Name.network)!]
        
        let item6: NSDictionary = ["title" : "share","image" : NSImage(named: NSImage.Name.shareTemplate)!]
        
        content.append(item1)
        content.append(item2)
        content.append(item3)
        content.append(item4)
        content.append(item5)
        content.append(item6)
        
        self.collectionView.content = content
    }
}






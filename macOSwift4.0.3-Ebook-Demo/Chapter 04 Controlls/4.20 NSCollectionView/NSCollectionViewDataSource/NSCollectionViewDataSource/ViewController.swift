//
//  ViewController.swift
//  NSCollectionViewDataSource
//
//  Created by iDevFans on 16/7/4.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa


extension NSUserInterfaceItemIdentifier {
    static let collectionViewItem = NSUserInterfaceItemIdentifier("CollectionViewItem")
}


class ViewController: NSViewController{

    @IBOutlet weak var collectionView: NSCollectionView!
    
    var content = [NSDictionary]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
        
        self.collectionView.register(CollectionViewItem.self, forItemWithIdentifier: .collectionViewItem)
  
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.updateData()
    }


    
    
    func updateData(){
        
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
        
        
        self.collectionView.reloadData()
        
    }
    
}


extension ViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier:.collectionViewItem, for: indexPath)
        let itemIndex = (indexPath as NSIndexPath).item
        item.representedObject = content[itemIndex]
        return item
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
}

extension ViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print(indexPaths)
    }
}




extension ViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 100, height: 100)
    }
}






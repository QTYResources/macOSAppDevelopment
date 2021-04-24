//
//  AppDelegate.swift
//  NSCollectionViewHeadFoot
//
//  Created by zhaojw on 2017/10/22.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa


extension NSUserInterfaceItemIdentifier {
    static let collectionViewItem = NSUserInterfaceItemIdentifier("CollectionViewItem")
    static let headViewItem = NSUserInterfaceItemIdentifier("HeaderView")
    static let footerViewItem = NSUserInterfaceItemIdentifier("FooterView")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var content = [NSDictionary]()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        self.collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
        
        self.collectionView.register(CollectionViewItem.self, forItemWithIdentifier: .collectionViewItem)
        
        self.collectionView.register(HeaderView.self, forItemWithIdentifier: .headViewItem)
        self.collectionView.register(FooterView.self, forItemWithIdentifier: .footerViewItem)
        
        
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.updateData()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
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


extension AppDelegate: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        
        if kind == NSCollectionView.SupplementaryElementKind.sectionHeader {
            let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.SupplementaryElementKind.sectionHeader, withIdentifier: .headViewItem, for: indexPath)
            return view
        }
        
        if kind == NSCollectionView.SupplementaryElementKind.sectionFooter {
            let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.SupplementaryElementKind.sectionFooter, withIdentifier: .footerViewItem, for: indexPath)
            return view
        }
        
        return NSView()
       
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier:.collectionViewItem, for: indexPath)
        let itemIndex = (indexPath as NSIndexPath).item
        item.representedObject = content[itemIndex]
        return item
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 2
    }
    
}

extension AppDelegate: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print(indexPaths)
    }
}




extension AppDelegate: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize(width: collectionView.frame.size.width, height: 30)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForFooterInSection section: Int) -> NSSize {
          return NSSize(width: collectionView.frame.size.width, height: 60)
    }
}


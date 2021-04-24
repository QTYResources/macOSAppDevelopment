//
//  ViewController.swift
//  NSOutlineViewDragDrop
//
//  Created by iDevFans on 16/7/26.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

let kDragOutlineViewTypeName = "kDragOutlineViewTypeName"
let dragOutlineViewTypeName = NSPasteboard.PasteboardType(rawValue: kDragOutlineViewTypeName)
class ViewController: NSViewController {
    lazy var nodes: Array = {
        return [NSMutableDictionary]()
    }()
    
    @IBOutlet weak var treeView: NSOutlineView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configData()
        self.registerDrag()
        self.treeView.reloadData()
        self.treeView.expandItem(nil, expandChildren: false)
    }
    
    //注册拖放
    func registerDrag() {
        self.treeView.registerForDraggedTypes([dragOutlineViewTypeName])
    }
    
    //配置测试数据
    func configData() {
        let group1 = NSMutableDictionary()
        let group2 = NSMutableDictionary()
        group1["name"] = "Group1"
        group2["name"] = "Group2"
        
        let member11 = NSMutableDictionary()
        member11["name"] = "member11"
  
        let member12 = NSMutableDictionary()
        member12["name"] = "member12"
   
        
        let children1 = [ member11,member12]

        let member21 = NSMutableDictionary()
        member21["name"] = "member21"

        let member22 = NSMutableDictionary()
        member22["name"] = "member22"

        let member23 = NSMutableDictionary()
        member23["name"] = "member23"
       
        
        let children2 = [member21,member22,member23]
        
        group1["children"] = NSMutableArray(array: children1)
        group2["children"] = NSMutableArray(array: children2)
        
        self.nodes.append(group1)
        self.nodes.append(group2)
    }
}

extension ViewController:NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if(item == nil) {
            return self.nodes.count
        }
        let node = item as! NSMutableDictionary
        if let children = node["children"] as? NSArray   {
            return children.count
        }
        return 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {

        if(item==nil) {
            return  self.nodes[index]
        }
        let node = item as! NSMutableDictionary
        let children = node["children"] as! NSArray
        return  children[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return true
    }
    
    
    //将拖放的节点数据 存储到剪切板
    func outlineView(_ outlineView: NSOutlineView, writeItems items: [Any], to pasteboard: NSPasteboard) -> Bool {
        if  items.count == 0 {
            return false
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: items)
        pasteboard.declareTypes([dragOutlineViewTypeName], owner: self)
        pasteboard.setData(data, forType: dragOutlineViewTypeName)
        return true
    }
    
    //节点允许拖放
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        return .every
    }
    
    //拖放数据接收处理
    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
        let pboard = info.draggingPasteboard()
        let data = pboard.data(forType: dragOutlineViewTypeName)
        let items = NSKeyedUnarchiver.unarchiveObject(with: data!)
        guard let itemsData = items else {
            return false
        }
        
        let targetNodeItem = item as! NSMutableDictionary
        var children = targetNodeItem["children"] as? NSMutableArray
        //如果拖放的目标节点没有孩子，则创建一个新孩子节点
        if children == nil {
            children =  NSMutableArray()
            targetNodeItem["children"] = children
        }
        //将数据添加到目标节点的children中
        children?.addObjects(from: itemsData as! [AnyObject])
       
        //重新加载数据
        outlineView.reloadData()
        return true
    }
}


extension ViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        let view = outlineView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self)
        let subviews  = view?.subviews
       
        let field = subviews?[0] as! NSTextField
        let node = item as! NSMutableDictionary
        
        if let name = node["name"] {
            field.stringValue = name as! String
        }
        return view
    }
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 20
    }
    
}

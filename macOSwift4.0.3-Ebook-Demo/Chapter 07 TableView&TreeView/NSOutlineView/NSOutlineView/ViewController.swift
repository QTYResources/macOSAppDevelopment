//
//  ViewController.swift
//  NSOutlineView
//
//  Created by iDevFans on 16/7/11.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var treeView: OutlineView!
    
    @IBOutlet var treeMenu: NSMenu!
    
    var treeModel: TreeNodeModel = TreeNodeModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configData()
        self.treeView.nodeMenu = self.treeMenu
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func configData() {
        
        let rootNode = TreeNodeModel()
        rootNode.name = "网易"
        
        let rootNode2 = TreeNodeModel()
        rootNode2.name = "腾讯"
        
        self.treeModel.childNodes.append(rootNode)
        self.treeModel.childNodes.append(rootNode2)
        
        
        let level11Node = TreeNodeModel()
        level11Node.name = "电商"
        
        let level12Node = TreeNodeModel()
        level12Node.name = "游戏"
        
        let level13Node = TreeNodeModel()
        level13Node.name = "音乐"
        
        
        rootNode.childNodes.append(level11Node)
        rootNode.childNodes.append(level12Node)
        rootNode.childNodes.append(level13Node)
        
        rootNode2.childNodes.append(level13Node)
       
        
        
        let level21Node = TreeNodeModel()
        level21Node.name = "研发"
        
        let level22Node = TreeNodeModel()
        level22Node.name = "运营"
        
        level11Node.childNodes.append(level21Node)
        level11Node.childNodes.append(level22Node)
        
        
        self.treeView.reloadData()
        

    }

    
    @IBAction func addNodeAction(_ sender: NSButton) {
        
        let nodeName = self.textField.stringValue
        if nodeName.characters.count <= 0 {
            let alert = NSAlert()
            //增加一个按钮
            alert.addButton(withTitle: "Ok")
            //提示的标题
            alert.messageText = "Alert"
            //提示的详细内容
            alert.informativeText = "please input node name"
            //设置告警风格
            alert.alertStyle = .informational
            alert .beginSheetModal(for: self.view.window!, completionHandler:nil
            )
            return
        }
        
        let item : TreeNodeModel?
        
        let row = self.treeView.selectedRow
        //没有节点选中时 默认增加到跟节点
        if row < 0 {
            item = self.treeModel
        }
        else {
             item = self.treeView.item(atRow: row) as? TreeNodeModel
        }

        let addNode = TreeNodeModel()
        addNode.name = nodeName
        
        item?.childNodes.append(addNode)
        
        self.treeView .reloadData()
    }
    
    @IBAction func removeNodeAction(_ sender: NSButton) {
        
        let row = self.treeView.selectedRow
        //如果没有节点选中 则返回
        if row < 0 {
            return
        }
        
        let item = self.treeView.item(atRow: row) as? TreeNodeModel
        let parentItem = self.treeView.parent(forItem: item)
        //nil 表示为根节点
        if parentItem == nil {
            self.treeModel = TreeNodeModel()
        }
        else {
            let parentModel = parentItem as! TreeNodeModel
            var index = 0
            for itemModel in parentModel.childNodes {
                if itemModel.name == item?.name {
                    parentModel.childNodes .remove(at: index)
                    break
                }
                index = index + 1
            }
        }
        
        self.treeView .reloadData()
    }

}









extension ViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        let view = outlineView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self)
        let subviews  = view?.subviews
        let imageView = subviews?[0] as! NSImageView
        
        let field = subviews?[1] as! NSTextField
        let model = item as! TreeNodeModel
        
        field.stringValue = model.name!
        
        if model.childNodes.count <= 0 {
            imageView.image = NSImage(named: NSImage.Name.listViewTemplate)
        }
        
        return view
    }
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 40
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        
        let treeView = notification.object as! NSOutlineView
        let row = treeView.selectedRow
        let model = treeView.item(atRow: row)
        
        let p = treeView.parent(forItem: model)
        
        print("model:\(model)")
        
        print("p:\(p)")
    }
}




extension ViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        
        
        let rootNode:TreeNodeModel
        
        if item != nil {
            rootNode = item as! TreeNodeModel
        }
        else {
            rootNode =  self.treeModel
        }
        
        return rootNode.childNodes.count
       
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        
        let rootNode:TreeNodeModel
        
        if item != nil {
            rootNode = item as! TreeNodeModel
        }
        else {
            rootNode =  self.treeModel
        }
        
        return rootNode.childNodes[index]

    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        
        let rootNode:TreeNodeModel = item as! TreeNodeModel
        
        return rootNode.childNodes.count > 0
        
    }
}

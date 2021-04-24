//
//  ViewXibViewController.swift
//  TableViewControllerDemo
//
//  Created by iDevFans on 16/8/21.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewXibViewController: TableDataNavigationViewController {
    
    @IBOutlet weak var myTableView: NSTableView!
    
    @IBOutlet weak var myTableScrollView: NSScrollView!
    
    
    @IBOutlet weak var dataNavView: DataNavigationView!
    
    lazy var dataDelegate: TableDataNavigationViewDelegate = {
        let dataDelegate = TableDataNavigationViewDelegate()
        return dataDelegate
    }()
    
    lazy var queue: DispatchQueue = {
        let queue = DispatchQueue(label: "macdec.io.example")
        return queue
    }()
    
    var datas: Array = [Dictionary<String,Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make test datas
        self.makeTestDatas()
        
        //计算分页数据
        self.pageManager.delegate = self
        self.pageManager.pageSize = 5;
        self.pageManager.computePageNumbers()
        //导航到第一页
        self.pageManager.goFirstPage()
        //更新导航面板分页提示信息
        self.updatePageInfo()
        
        self.tableViewSortColumnsConfig()
        
    }
    
    
    override func tableViewXibScrollView() ->NSScrollView? {
        return self.myTableScrollView
    }
    
    override func tableXibView() ->NSTableView? {
        return self.myTableView
    }
    
    override func dataNavigationXibView() ->DataNavigationView? {
        return self.dataNavView
    }
    
    
    override func tableDelegateConfig(){
        self.tableView?.delegate = self.dataDelegate
        self.tableView?.dataSource = self.dataDelegate
        self.dataDelegate.owner = self.tableView
    }
    
    
    func findBy(page:Int , pageSize: Int) -> [Dictionary<String,Any>]? {
        let count = self.datas.count
        if count < 0 {
            return [Dictionary<String,AnyObject>]()
        }
        
        let  fromIndex = page * pageSize
        let  toIndex   = fromIndex + pageSize
        
        var  validPageSize = pageSize
        
        if toIndex > count {
            validPageSize = count - fromIndex
        }
        let range = fromIndex ..< fromIndex+validPageSize
        
        let subDatas = self.datas[range]
        
        return Array(subDatas)
    }
    
    func makeTestDatas(){
        
        let image = NSImage(named: NSImage.Name.computer)
        let folderImage = NSImage(named: NSImage.Name.folder)
        let advancedImage = NSImage(named: NSImage.Name.advanced)
        let unavailableImage = NSImage(named: NSImage.Name.statusUnavailable)
        
        
        let row1: Dictionary<String,Any> = ["field":"name","type":"text","size":"10","primary":(1),"image":image!]
        
        let row2: Dictionary<String,Any> = ["field":"address","type":"text","size":"14","primary":(0),"image":folderImage!]
        
        let row3: Dictionary<String,Any> = [ "field":"age","type":"int","size":"8","primary":(0),"image":advancedImage! ]
        
        let row4: Dictionary<String,Any> = [ "field":"phone","type":"text","size":"6","primary":(0),"image":image!]
        
        let row5: Dictionary<String,Any> = [ "field":"city","type":"text","size":"12","primary":(0), "image":unavailableImage!]
        
        let row6: Dictionary<String,Any> = [ "field":"phone2","type":"text","size":"10","primary":(0) ,"image":image!]
        
        let row7: Dictionary<String,Any> = [ "field":"city2","type":"text","size":"20","primary":(0), "image":advancedImage!]
        
        let row8: Dictionary<String,Any> = [ "field":"name2","type":"text","size":"13","primary":(0) ,"image":folderImage!]
        
        let row9: Dictionary<String,Any> = [ "field":"address2","type":"text","size":"15","primary":(0),"image":unavailableImage! ]
        
        let row10: Dictionary<String,Any> = [ "field":"age","type":"int","size":"8","primary":(0),"image":advancedImage! ]
        let row11: Dictionary<String,Any> = [ "field":"phone","type":"text","size":"10","primary":(0),"image":advancedImage!]
        
        let row12: Dictionary<String,Any> = [ "field":"city","type":"text","size":"16","primary":(0) ,"image":folderImage!]
        
        let row13: Dictionary<String,Any> = [ "field":"phone","type":"text","size":"10","primary":(0) ]
        let row14: Dictionary<String,Any> = [ "field":"city","type":"text","size":"30","primary":(0),"image":image! ]
        
        let testDatas = [row1,row2,row3,row4,row5,row6,row7,row8,row9,row10,row11,row12,row13,row14]
        
        self.datas  = testDatas
        
    }
    
    
    override func tableColumnItems() ->[TableColumnItem] {
        
        let field = TableColumnItem()
        field.title      = "Field"
        field.identifier = "field"
        field.width      = 100
        field.minWidth   = 100
        field.maxWidth   = 120
        field.editable   = true
        field.headerAlignment = .left
        field.cellType = .textField
        
        let type = TableColumnItem()
        type.title      = "Type"
        type.identifier = "type"
        type.width      = 120
        type.minWidth   = 120
        type.maxWidth   = 160
        type.editable   = true
        type.headerAlignment = .left
        type.cellType = .comboBox
        type.items = ["int","varchar","bool"]
        
        
        let length = TableColumnItem()
        length.title      = "Size"
        length.identifier = "size"
        length.width      = 120
        length.minWidth   = 120
        length.maxWidth   = 120
        length.editable   = true;
        length.headerAlignment = .left
        length.cellType = .textField
        
        
        let primary = TableColumnItem()
        primary.title      = "Primary"
        primary.identifier = "primary"
        primary.width      = 80
        primary.minWidth   = 80
        primary.maxWidth   = 120
        primary.editable   = true
        primary.headerAlignment = .left
        primary.cellType = .checkBox
        
        
        let image = TableColumnItem()
        image.title      = "Image";
        image.identifier = "image";
        image.width      = 80;
        image.minWidth   = 80;
        image.maxWidth   = 120;
        image.cellType = .imageView;
        
        
        return [field,type,length,primary,image]
    }
    
    
    // MARK: action
    
    override func addNewData() {
        
    }
    
    override func reomoveSelectedData() {
        let selectedRow = self.tableView?.selectedRow
        //没有行选择,不执行删除操作
        if selectedRow! < 0 {
            return
        }
        super.reomoveSelectedData()
        self.dataDelegate.deleteDataAt(index: selectedRow!)
        self.datas.remove(at: selectedRow!)
        //更新页数据
        self.computePageNumbers()
        self.updatePageInfo()
    }
}


extension ViewXibViewController: PaginatorDelegate {
    
    func paginator(id:AnyObject , pageIndex index:Int, pageSize size:Int ) {
        
        self.queue.async {
            let datas = self.findBy(page: index, pageSize: size)
            self.dataDelegate.setData(data: datas as AnyObject?)
            DispatchQueue.main.async {
                self.tableView?.reloadData()
                self.updatePageInfo()
            }
        }
    }
    
    func totalNumberOfData(_ id:AnyObject) ->Int {
        return self.datas.count
    }
}


//
//  NationPanel.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/8/27.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class NationPanel: NSPanel {
    //var nations:
    
    @IBOutlet weak var tableView: NSTableView!
    
    //所有语言
    var nations = [AppleNationVM]()
    
    //选中的语言
    var selectedNations = [AppleNationVM]()
    
    lazy var queue: DispatchQueue = {
        let queue = DispatchQueue(label: "macdec.io.localization")
        return queue
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        fetchNations()
    }
    
    func fetchNations() {
        self.queue.async {
            self.nations = NationBO.shared.appleNationsVM!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Button Action
    
    @IBAction func okAction(_ sender: AnyObject?) {
       self.parent?.endSheet(self, returnCode: NSApplication.ModalResponse(rawValue: kOkCode))
    }
    
    @IBAction func cancelAction(_ sender: AnyObject?) {
        self.parent?.endSheet(self, returnCode: NSApplication.ModalResponse(rawValue: kCancelCode))
    }
    
    @IBAction func allSelectionAction(_ sender: NSButton) {
      
        for nation in nations {
            nation.selectedState = sender.state.rawValue
        }
        self.tableView?.reloadData()
       
    }
}

extension NationPanel: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return nations.count
    }
}


extension NationPanel: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let nation = self.nations[row]
        //表格列的标识
        let key = (tableColumn?.identifier)!
   
        //根据表格列的标识,创建单元视图
        let view = tableView.makeView(withIdentifier: key, owner: self)
        
        let subviews = view?.subviews
        if (subviews?.count)! <= 2 {
            return nil
        }
        
        let checkBtn = subviews?[0] as! NSButton
        checkBtn.state = NSControl.StateValue(rawValue: nation.selectedState)

        checkBtn.target = self
        checkBtn.action = #selector(NationPanel.checkBoxChick(_:))
        
        let imageView = subviews?[1] as! NSImageView
        
        let imageName = NationUtil.nationFlagImageName(nationName: nation.code!)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        imageView.image = image;
        
        let nationStr = "\(nation.name!)(\(nation.code!))"
        
        let textField = subviews?[2] as! NSTextField
        textField.stringValue = nationStr
        
        return view
    }
    
    @IBAction func checkBoxChick(_ sender:NSButton) {

        
        let pView =  sender.superview
       
        let aPoint = pView?.superview?.frame.origin
        
        let row = (self.tableView?.row(at: aPoint!))!
    
        if row < 0 {
            return
        }
        
        let nation = self.nations[row]
        
        nation.selectedState = sender.state.rawValue

        self.selectedNations = self.nations.filter({ $0.selectedState == 1 })
    
    }
}

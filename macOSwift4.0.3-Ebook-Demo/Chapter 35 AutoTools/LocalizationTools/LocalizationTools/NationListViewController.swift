//
//  NationListViewController.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/8/24.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let kCancelCode = 0
let kOkCode = 1

let kProjectPath = "ProjectPath"

class NationListViewController: NSViewController {
   
    @IBOutlet weak var dataNavigationView: DataNavigationView!
    
    @IBOutlet weak var tableView: NationListView!
    
    var projectPath: String?
    
    var localizationProject: LocalizationProject?
    
    var datas = [LocalizationLang]()
    
    var currentLocalizationFile: LocalizationFile?
    
    lazy var queue: DispatchQueue = {
        let queue = DispatchQueue(label: "macdec.io.localization")
        return queue
    }()
    
    var topLevelArray: NSArray?

    lazy var nationPanel: NationPanel? = {
        var panel: NationPanel?
        let nib  = NSNib.init(nibNamed: NSNib.Name(rawValue: "NationPanel"), bundle: Bundle.main)
        if let success =  nib?.instantiate(withOwner: self, topLevelObjects: &topLevelArray) {
            if success {
                for obj in self.topLevelArray! {
                    if obj is NationPanel {
                        panel = obj as? NationPanel
                        break
                    }
                }
            }
        }
        return panel
    }()
    
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataNavigationView.setUpNavigationViewWithItems(self.dataNavigationItemsConfig())
        self.dataNavigationView.target = self
        self.dataNavigationView?.action = #selector(NationListViewController.toolButtonClicked(_:))
        self.tableViewStyleConfig()
        self.registerNotification()
        self.tableView.dragDelegate = self
        
        self.projectPath = UserDefaults.standard.object(forKey: kProjectPath) as? String
        
        if self.projectPath != nil {
            parseProject()
        }
    }
    
    override func viewDidAppear() {

        super.viewDidAppear()
        
        var frame = NSScreen.main?.visibleFrame
        
        frame?.size.height = 100
        frame?.size.width  = 200
        
        self.view.window?.setFrame(frame!, display: true)
        
        self.view.window?.center()
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector:#selector(NationListViewController.onOpenXcodeFile(_:)),  name:NSNotification.Name.onOpenXcodeFile, object: nil)
    }
    
    @objc func onOpenXcodeFile(_ notification: Notification){
        
        let path = notification.object as! String
        
        self.didFinishDrag(path)
        
    }
    
    func parseProject() {
        
        self.queue.async {

            self.localizationProject = LocalizationProject(path: self.projectPath!)
            self.localizationProject?.localizationParse()
            let files = (self.localizationProject?.localizationFiles())!
            
            DispatchQueue.main.async {
                
                if files.count > 0 {
                    self.currentLocalizationFile = files[0]
                    self.datas = self.currentLocalizationFile!.languages
                    let deadlineTime = DispatchTime.now() + .milliseconds(300)
                    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                        
                        //方法1  使用系统API 选中第一行
                      
                        self.setTableViewFocus()
                        
                        return
                        
                        //方法2 模拟鼠标点击选中第一行
                        let rect = self.tableView.rect(ofRow: 0)
                        let screen = NSScreen.main
                        let pointInScreen = screen?.convertToScreenFromLocalPoint(point: rect.origin, relativeToView: self.tableView)
                        MouseAutoClick.post(at:pointInScreen!)
                        
                    }
                }
                else {
                    self.datas =  [LocalizationLang]()
                }
                
                self.tableView.reloadData()
                
            }
        }
    }
    
    func setTableViewFocus() {
        let indexSet = IndexSet.init(integer: 0)
        self.tableView.selectRowIndexes(indexSet, byExtendingSelection: false)
        self.view.window?.makeFirstResponder(self.tableView)
    }
    
    func tableViewStyleConfig() {
        let bkColor = NSColor(hex:0x2c3135)
        self.tableView.backgroundColor = bkColor
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bkColor.cgColor
    }
    
    @IBAction func toolButtonClicked(_ sender: NSButton) {
        let actionType = DataNavigationViewButtonActionType(rawValue: sender.tag)!
        
        switch (actionType) {
            
        case .add:
            self.addNationData()
            break
            
        case .remove:
            self.removeSelectedData()
            break
            
        default:
            self.refreashData()
            break
            
        }
        
    }
    
    func addNationData(){
        guard let nationPanel = nationPanel else {
            return
        }
        nationPanel.parent = self.view.window
        self.view.window?.beginSheet(nationPanel, completionHandler: {  returnCode in
            if returnCode.rawValue == kOkCode {
                print("returnCode \(returnCode)")
                
                let selected = nationPanel.selectedNations
                
                let fileParentFoder = self.currentLocalizationFile?.path
                
                for nationVM in selected {
                    let lang = LocalizationLang()
                    lang.name = nationVM.code!
                    
                    
                    let langFolder = fileParentFoder?.appendingPathComponent(path: "\(lang.name).lproj")
                    
                    let langPath = langFolder?.appendingPathComponent(path: kKeyStringsFile)
                    
                    lang.path = langPath!
                    
                    lang.file = self.currentLocalizationFile
                    
                    
                    _ = FileManager.default.createPathIfNeded(path: langFolder!)
                    
                    let fileContent = self.currentLocalizationFile?.baseLanguage()?.fileContent()!
                    
                    let fileURL = URL(fileURLWithPath: lang.path)
                    
                    _ = try? fileContent?.write(to: fileURL, atomically: true, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                    
                    self.currentLocalizationFile?.addNewLanguage(lang: lang)
                }
                
                self.datas = self.currentLocalizationFile!.languages
                self.tableView.reloadData()
                self.setTableViewFocus()
            }
        })
    }
    
    func removeSelectedData(){
        
    }
    
    func refreashData(){
        self.parseProject()
    }


    func dataNavigationItemsConfig() -> [DataNavigationItem] {
        let insertItem = DataNavigationButtonItem()
        insertItem.imageName = "toolbar-add"
        insertItem.tooltips = "insert a row into current table"
        insertItem.tag = .add
        
        let deleteItem = DataNavigationButtonItem()
        deleteItem.imageName = "toolbar-remove"
        deleteItem.tooltips = "delete seleted rows form current table"
        deleteItem.tag = .remove
        
        let flexibleItem = DataNavigationFlexibleItem()
        
        let refreshItem = DataNavigationButtonItem()
        refreshItem.imageName = "toolbar-refresh"
        refreshItem.tooltips = "reload table data"
        refreshItem.tag = .refresh
        
        return [insertItem,deleteItem,flexibleItem,refreshItem]
    }
}

extension NationListViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let loc = self.datas[row]
        //表格列的标识
        let key = (tableColumn?.identifier)!
        
        
        let view = tableView.makeView(withIdentifier: key, owner: self)
        let subviews = view?.subviews
        if (subviews?.count)! <= 0 {
            return nil
        }

        let imageView = subviews?[0] as! NSImageView
        
        let imageName = NationUtil.nationFlagImageName(nationName: loc.name)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        imageView.image = image;
        
        let textField = subviews?[1] as! NSTextField
        
        let nationName =  NationBO.shared.nationName(fromCode: loc.name)
        if nationName != nil {
            textField.stringValue = nationName!
        }
        else{
            textField.stringValue = loc.name
        }
        
        return view
    }
    
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        let row = tableView.selectedRow
        
        if row < 0 { //没有选中任何语言
            return
        }
        let loc = self.datas[row]
        let filePath = loc.path
        NotificationCenter.default.post(name:Notification.Name.onSelectedFile, object: filePath)
        
    }
}

extension NationListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
}

extension NationListViewController: FileDragDelegate {
    func didFinishDrag(_ filePath:String) {
        
        if !FileManager.default.fileExists(atPath: filePath) {
            return
        }
        self.projectPath = filePath
        self.parseProject()
        //Save Project Path
        UserDefaults.standard.set(filePath, forKey: kProjectPath)
        UserDefaults.standard.synchronize()
    }
}


extension Notification.Name {
    //定义消息通知名称
    static let onSelectedFile = Notification.Name("on-selected-file")
    
    static let onOpenXcodeFile = Notification.Name("on-open-xcode-file")
}




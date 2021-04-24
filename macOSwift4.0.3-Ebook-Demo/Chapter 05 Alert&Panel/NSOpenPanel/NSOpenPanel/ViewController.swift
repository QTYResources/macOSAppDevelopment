//
//  ViewController.swift
//  NSOpenPanel
//
//  Created by iDevFans on 16/7/7.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    lazy var font = NSFont()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func openFilePanel(_ sender: AnyObject) {
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["txt"]
    
        openDlg.begin(completionHandler: { [weak self]  result in
            
            if(result.rawValue == NSFileHandlingPanelOKButton){
                
                let fileURLs = openDlg.urls
                
                for url: URL in fileURLs  {
                   
                    guard let text = try?  NSString.init(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
                        else {
                            return
                    }
                    self?.textView.string = text as String
                }
                
            }
            
         })
    }
    
    
    
//    NSSavePanel *saveDlg = [[NSSavePanel alloc]init];
//    saveDlg.title = @"Save File";
//    saveDlg.message = @"Save My File";
//    saveDlg.allowedFileTypes = @[@"txt"];
//    saveDlg.nameFieldStringValue = @"my";
//    [saveDlg beginWithCompletionHandler: ^(NSInteger result){
//    if(result==NSFileHandlingPanelOKButton){
//    NSURL  *url =[saveDlg URL];
//    NSLog(@"filePath url%@",url);
//    NSString *text = self.textView.string;
//    NSError *error;
//    [text writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    if(error){
//    NSLog(@"save file error %@",error);
//    }
//    }
//    }];
    
    
    @IBAction func saveFileAction(_ sender: AnyObject) {
        
        let text = self.textView.string
        
        let saveFileDlg = NSSavePanel()
        saveFileDlg.title = "Save File"
        saveFileDlg.message = "Save My File"
        saveFileDlg.allowedFileTypes = ["txt"]
        saveFileDlg.nameFieldStringValue = "my"
        
        saveFileDlg.begin(completionHandler: { result in
        
            if result.rawValue==NSFileHandlingPanelOKButton {
                
                let url = saveFileDlg.url
                
                _ = try? text.write(to: url!, atomically: true, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            }
        
        })
    }
    
    
    @IBAction func selectColorAction(_ sender: AnyObject) {
        let colorpanel = NSColorPanel.shared
        colorpanel.setAction(#selector(changeTextColor(_:)))
        colorpanel.setTarget(self)
        colorpanel.orderFront(nil)
    }
    
    
    @objc func changeTextColor(_ sender: NSColorPanel){
       let color = sender.color;
       self.textView.textColor = color
    }
    
    

    @IBAction func selectFontAction(_ sender: AnyObject) {
        let fontManager = NSFontManager.shared
        fontManager.target = self
        fontManager.action = #selector(changeTextFont(_:))
        fontManager.orderFrontFontPanel(self)
    }
    
    @objc func changeTextFont(_ sender: NSFontManager){
        self.font = sender.convert(self.font)
        self.textView.font = self.font
    }
}















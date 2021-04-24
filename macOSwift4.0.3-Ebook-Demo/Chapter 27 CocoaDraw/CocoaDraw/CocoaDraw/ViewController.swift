//
//  ViewController.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/8.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    

    @IBAction func colorAction(_ sender: AnyObject) {
        
        let well = sender as! NSColorWell
        
        print("select color is \(well.color)")
    }

    @IBAction func changeColorButtonAction(_ sender: AnyObject) {
        
        let panel = NSColorPanel.shared
        panel.setTarget(self)
        panel.setAction(#selector(self.colorSelect))
        panel.orderFront(self)
    }
    
    
    @IBAction func colorSelect(_ sender: AnyObject) {
        let panel = sender as! NSColorPanel
        self.textView.textColor = panel.color
        
      
        
    }
    
    @IBAction func saveImageAction(_ sender: AnyObject) {
        
        self.saveImage()
    }
    
    func saveImage(){
        
        let data = self.view.dataWithPDF(inside: self.view.bounds)
        //视图的image
        let viewImage = NSImage(data: data)
        //获取ImageRep
        let imageRep = NSBitmapImageRep(data: (viewImage?.tiffRepresentation)!)        //图象压缩比设置
        let imageProps = [ NSBitmapImageRep.PropertyKey.compressionFactor : Int(1.0) ]
        //Data数据
        let imageData = imageRep?.representation(using: .png, properties: imageProps)
        
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        
         //文件路径 URL
        let fileURL = URL(fileURLWithPath:documentsDirectory).appendingPathComponent("image.png")
       
        //写入文件
        try? imageData?.write(to: fileURL)
        
    }

}







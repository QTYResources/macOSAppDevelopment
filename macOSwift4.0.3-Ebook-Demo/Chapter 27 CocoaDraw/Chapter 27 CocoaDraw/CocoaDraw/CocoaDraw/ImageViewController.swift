//
//  ImageViewController.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
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
        let imageProps = [ NSImageCompressionFactor : Int(1.0) ]
        //Data数据
        let imageData = imageRep?.representation(using: .PNG, properties: imageProps)
        
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        
        //文件路径 URL
        let fileURL = URL(fileURLWithPath:documentsDirectory).appendingPathComponent("image.png")
        
        //写入文件
        try? imageData?.write(to: fileURL)
        
    }
}

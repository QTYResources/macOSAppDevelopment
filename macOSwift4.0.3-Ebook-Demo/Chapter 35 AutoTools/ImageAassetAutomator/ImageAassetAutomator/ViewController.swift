//
//  ViewController.swift
//  ImageAassetAutomator
//
//  Created by iDevFans on 16/8/22.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


let  kIPhone: String   = "iPhone"
let  kIPad: String     = "iPad"
let  kMacOS: String    = "macOS"

let  kAppIconFolderName: String      =   "AppIcon.appiconset"
let  kAppIconContensFileName: String  =  "Contents.json"

public enum AppImageType : Int {
    
    case iPhone
    
    case iPad
    
    case iPhoneIpad
    
    case macOS
    
}

class ViewController: NSViewController {

    @IBOutlet weak var imageView: DragImageView!
    
    @IBOutlet weak var typeComboBox: NSComboBox!
    
    @IBOutlet weak var exportButton: NSButton!
    
    var largeImagePath: String?
    var assetPath: String?
    var exportPath: String?
    var imageScaleConfig: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUIView()
        self.readImageScaleConfig()
    }

    func setUpUIView() {
        self.imageView.delegate = self
        self.exportButton.isEnabled = false
    }
    
    //plist文件读取
    func readImageScaleConfig() {
        let filePath = Bundle.main.path(forResource: "imageSize", ofType: "plist")
        let dataMap = NSDictionary(contentsOfFile: filePath!)
        self.imageScaleConfig = dataMap
    }
    
    
    @IBAction func makeAppIconAction(_ sender: NSButton) {
        self.makeAsserts()
        
        
    }
    
    
    func makeAsserts(){
        if self.largeImagePath == nil {
            return
        }
        
        var selectedIndex = self.typeComboBox.indexOfSelectedItem;
        if selectedIndex < 0 {
            selectedIndex = 0
        }
        let appIconType = AppImageType.init(rawValue: selectedIndex)!
        //图片裁剪
        self.makeAppIconWithType(appIconType)
        
        //Contents.json文件生成
        self.makeJSONFileWithType(appIconType)
        
        
    }
    
    //根据1024*1024大图生成不同平台图标
    func makeAppIconWithType(_ type:AppImageType) {
        
        let imageFolerPath = (self.exportPath! as NSString).appendingPathComponent(kAppIconFolderName)
        let fm  = FileManager()
        let success = fm.createPathIfNeded(path: imageFolerPath)
        if !success {
            return
        }
        
        //清除目录,防止以前存在垃圾文件
        fm.clearAllFilesAtPath(path: imageFolerPath)
        
        let largeImage = NSImage(contentsOfFile: self.largeImagePath!)

        let configs = self.platAssetsConfig(type)
       
        for config in configs {
            let imageSizeConfig = config["imageSizeConfig"] as? Dictionary<String,Any>
            let imageFlag = config["imageFlag"]!
            let keys = imageSizeConfig?.keys
            
            for key in keys! {
                let scales = imageSizeConfig?[key] as! [NSNumber]
                let size = Int(key)!
                for scaleNum in scales {
                    print("key = \(key) type = \(scaleNum.className)")
                    let scale = scaleNum.intValue
                    let retion = scale
                    let imageSize = NSSize(width: size*retion, height: size*retion)
                    //按新的尺寸生成图像
                    let image = largeImage?.reSize(size: imageSize)
                    var imageName: String
                    if retion == 1 {
                        imageName = "icon_\(imageFlag)_\(size).png"
                    }
                    else {
                        imageName = "icon_\(imageFlag)_\(size)@\(retion)x.png"
                    }
                    let imagePath = (imageFolerPath as NSString).appendingPathComponent(imageName)
                    //保存图像
                    image?.saveAtPath(path: imagePath)
                }
            }
        }
    }


    
    //生成不同平台的JSON格式文件
    func makeJSONFileWithType(_ type:AppImageType) {
        let configs = self.platAssetsConfig(type)
        var images = [[String:Any]]()
        for config in configs {
            let imageSizeConfig = config["imageSizeConfig"] as? Dictionary<String,Any>
            let imageFlag = config["imageFlag"]!
            let keys = imageSizeConfig?.keys
            
            for key in keys! {
                let scales = imageSizeConfig?[key] as! [NSNumber]
                let size = Int(key)!
                for scaleNum in scales {
                    let scale = scaleNum.intValue
                    let retion = scale
                    var imageName: String
                    if retion == 1 {
                        imageName = "icon_\(imageFlag)_\(size).png"
                    }
                    else {
                        imageName = "icon_\(imageFlag)_\(size)@\(retion)x.png"
                    }
                    
                    
                    var imageInfo = [String:Any]()
    
                    imageInfo["size"] = "\(size)x\(size)"
                    imageInfo["idiom"] = imageFlag
                    imageInfo["filename"] = imageName
                    imageInfo["scale"] = "\(retion)x"
                    
                    images.append(imageInfo)

                }
            }
        }
        
        var jsonMap = [String:Any]()
        jsonMap["images"] = images
        jsonMap["info"] = ["version":1,"author":"xcode"]
        
        
        let data = try? JSONSerialization.data(withJSONObject: jsonMap, options: [.prettyPrinted])
        
        let imageFolerPath = (self.exportPath! as NSString).appendingPathComponent(kAppIconFolderName)
        
        let isOK = FileManager().createFileIfNeeded(filePath: imageFolerPath)
        if !isOK {
            return
        }
        
        try? data?.write(to: URL(fileURLWithPath: imageFolerPath))

    }
    
    //获取不同平台的图片配置
    func platAssetsConfig(_ type: AppImageType) ->[Dictionary<String,Any>] {
        var configs: [Dictionary<String,Any>]
        switch type {
        case .iPhone:
            let config = self.imageScaleConfig?[kIPhone]
            configs = [[
             "imageSizeConfig":config!,
             "imageFlag":kIPhone
            ]]
            break
        case .iPad:
            let config = self.imageScaleConfig?[kIPad]
            configs = [[
                "imageSizeConfig":config!,
                "imageFlag":kIPad
                ]]
            break
        case .macOS:
            let config = self.imageScaleConfig?[kMacOS]
            configs = [[
                "imageSizeConfig":config!,
                "imageFlag":kMacOS
                ]]
            break
        default: // iPhoneIPad
            let iPhoneConfig = self.imageScaleConfig?[kIPhone]
            let iPadConfig = self.imageScaleConfig?[kIPad]
            configs = [[
                       "imageSizeConfig":iPhoneConfig!,
                       "imageFlag":kIPhone
                       ],
                       ["imageSizeConfig":iPadConfig!,
                        "imageFlag":kIPad
                       ]
                      ]
            break
        }
        
        return configs
    }
    
    //用户当前文档目录
    func usrDocPath() ->String {
        let path =  NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0]
        return path
    }
}

// MARK: DragImageZoneDelegate

extension ViewController: DragImageZoneDelegate {
    
    func didFinishDragWithFile(_ filePath:String) {
        NSLog("filePath \(filePath)")
        self.largeImagePath = filePath
        self.exportPath = self.usrDocPath()
        self.exportButton.isEnabled = true
    }
}








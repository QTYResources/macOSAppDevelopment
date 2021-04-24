//
//  PersonProfile.swift
//  PersonProfileDoc
//
//  Created by iDevFans on 16/8/6.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let kPersonKey: String = "PersonKey"
class PersonProfile: NSObject , NSCoding {
    @objc var name: String?
    @objc var age: NSInteger = 0
    @objc var address: String?
    @objc var mobile: String?
    @objc var image: NSImage?

    func encode(with aCoder: NSCoder) {
        print("encodeWithCoder")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(mobile, forKey: "mobile")
        aCoder.encode(image, forKey: "image")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        print("decodeWithCoder")
        self.init()
        let name = aDecoder.decodeObject(forKey: "name") as? String
        self.name = name
        
        let age = aDecoder.decodeInteger(forKey: "age") as NSInteger
        self.age = age
 
        let address = aDecoder.decodeObject(forKey: "address") as? String
        self.address = address
        
        let mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        self.mobile = mobile
        
        let image = aDecoder.decodeObject(forKey: "image") as? NSImage
        self.image = image
    }
    
    static func profileFrom(_ data: Data) -> PersonProfile {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let aPerson = unarchiver.decodeObject(forKey: kPersonKey) as! PersonProfile
        return aPerson
    }
    
    func docData() -> Data {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self, forKey: kPersonKey)
        archiver.finishEncoding()
        return data as Data
    }
    
    func updata(with jsonData: Data?) {
        let  object = try? JSONSerialization.jsonObject(with: jsonData!, options: [.allowFragments])
        guard let dataDictionary = object as? Dictionary<String,AnyObject>
        else {
            return
        }
        self.name = dataDictionary["name"] as? String
        self.age = dataDictionary["age"] as! NSInteger
        self.address = dataDictionary["address"] as? String
        self.mobile = dataDictionary["mobile"] as? String
    }
    
    func jsonData() ->Data? {
        var dataDictionary  = Dictionary<String,Any>()
        if let name = self.name {
            dataDictionary["name"] = name
        }
        if  self.age > 0  {
            dataDictionary["age"] = age
        }
        if let address = self.address {
            dataDictionary["address"] = address
        }
        if let mobile = self.mobile {
            dataDictionary["mobile"] = mobile
        }
        let data = try? JSONSerialization.data(withJSONObject: dataDictionary, options: [.prettyPrinted])
        return data
    }
}



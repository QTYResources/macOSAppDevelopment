//
//  ClassInfo+CoreDataProperties.swift
//  SchoolV3
//
//  Created by iDevFans on 16/8/15.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import CoreData

extension ClassInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassInfo> {
        return NSFetchRequest<ClassInfo>(entityName: "ClassInfo");
    }

    @NSManaged public var photo: NSData?
    @NSManaged public var video: NSData?
    @NSManaged public var motto: String?
    @NSManaged public var belongToClass: Classes?

}

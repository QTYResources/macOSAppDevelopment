//
//  Classes+CoreDataProperties.swift
//  ClassesManager
//
//  Created by iDevFans on 16/8/14.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import CoreData

extension Classes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Classes> {
        return NSFetchRequest<Classes>(entityName: "Classes");
    }

    @NSManaged public var title: String?
    @NSManaged public var studentsNum: Int16

}

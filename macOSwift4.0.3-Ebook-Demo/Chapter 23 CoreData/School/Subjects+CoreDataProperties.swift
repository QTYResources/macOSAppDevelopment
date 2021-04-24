//
//  Subjects+CoreDataProperties.swift
//  School
//
//  Created by zhaojw on 2017/12/9.
//  Copyright © 2017年 zhaojw. All rights reserved.
//
//

import Foundation
import CoreData


extension Subjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subjects> {
        return NSFetchRequest<Subjects>(entityName: "Subjects")
    }

    @NSManaged public var name: String?
    @NSManaged public var sid: Int16

}

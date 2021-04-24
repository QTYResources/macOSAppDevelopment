//
//  Classes+CoreDataProperties.swift
//  School
//
//  Created by zhaojw on 2017/12/9.
//  Copyright © 2017年 zhaojw. All rights reserved.
//
//

import Foundation
import CoreData


extension Classes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Classes> {
        return NSFetchRequest<Classes>(entityName: "Classes")
    }

    @NSManaged public var studentsNum: Int16
    @NSManaged public var title: String?

}

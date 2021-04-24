//
//  Students+CoreDataProperties.swift
//  School
//
//  Created by zhaojw on 2017/12/9.
//  Copyright © 2017年 zhaojw. All rights reserved.
//
//

import Foundation
import CoreData


extension Students {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Students> {
        return NSFetchRequest<Students>(entityName: "Students")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var attribute: Int16
    @NSManaged public var profile: Profile?

}

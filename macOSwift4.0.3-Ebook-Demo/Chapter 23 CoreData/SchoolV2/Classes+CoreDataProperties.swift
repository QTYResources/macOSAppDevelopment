//
//  Classes+CoreDataProperties.swift
//  SchoolV2
//
//  Created by iDevFans on 16/9/24.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import CoreData


extension Classes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Classes> {
        return NSFetchRequest<Classes>(entityName: "Classes");
    }

    @NSManaged public var photo: NSData?
    @NSManaged public var slogan: String?
    @NSManaged public var studentsNum: Int16
    @NSManaged public var title: String?
    @NSManaged public var classStudent: NSSet?
    @NSManaged public var monitor: Students?
    @NSManaged public var teacher: NSManagedObject?

}

// MARK: Generated accessors for classStudent
extension Classes {

    @objc(addClassStudentObject:)
    @NSManaged public func addToClassStudent(_ value: Students)

    @objc(removeClassStudentObject:)
    @NSManaged public func removeFromClassStudent(_ value: Students)

    @objc(addClassStudent:)
    @NSManaged public func addToClassStudent(_ values: NSSet)

    @objc(removeClassStudent:)
    @NSManaged public func removeFromClassStudent(_ values: NSSet)

}

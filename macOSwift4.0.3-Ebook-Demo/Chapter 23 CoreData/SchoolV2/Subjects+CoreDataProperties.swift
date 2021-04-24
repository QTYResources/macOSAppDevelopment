//
//  Subjects+CoreDataProperties.swift
//  SchoolV2
//
//  Created by iDevFans on 16/8/14.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import CoreData

extension Subjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subjects> {
        return NSFetchRequest<Subjects>(entityName: "Subjects");
    }

    @NSManaged public var name: String?
    @NSManaged public var sid: Int16
    @NSManaged public var students: NSSet?

}

// MARK: Generated accessors for students
extension Subjects {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: Students)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: Students)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}

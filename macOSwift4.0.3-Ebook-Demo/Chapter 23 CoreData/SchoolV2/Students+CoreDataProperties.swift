//
//  Students+CoreDataProperties.swift
//  SchoolV2
//
//  Created by iDevFans on 16/8/14.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import CoreData

extension Students {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Students> {
        return NSFetchRequest<Students>(entityName: "Students");
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var inClass: Classes?
    @NSManaged public var profile: Profile?
    @NSManaged public var subjects: NSSet?

}

// MARK: Generated accessors for subjects
extension Students {

    @objc(addSubjectsObject:)
    @NSManaged public func addToSubjects(_ value: Subjects)

    @objc(removeSubjectsObject:)
    @NSManaged public func removeFromSubjects(_ value: Subjects)

    @objc(addSubjects:)
    @NSManaged public func addToSubjects(_ values: NSSet)

    @objc(removeSubjects:)
    @NSManaged public func removeFromSubjects(_ values: NSSet)

}

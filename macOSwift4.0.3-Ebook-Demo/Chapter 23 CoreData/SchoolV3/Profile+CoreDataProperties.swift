//
//  Profile+CoreDataProperties.swift
//  SchoolV2
//
//  Created by iDevFans on 16/8/14.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import CoreData

extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile");
    }

    @NSManaged public var address: String?
    @NSManaged public var birthday: NSDate?
    @NSManaged public var homephone: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var studentProfile: Students?

}

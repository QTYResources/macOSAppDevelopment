//
//  Profile+CoreDataProperties.swift
//  School
//
//  Created by zhaojw on 2017/12/9.
//  Copyright © 2017年 zhaojw. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var address: String?
    @NSManaged public var birthday: NSDate?
    @NSManaged public var homephone: String?
    @NSManaged public var photo: NSData?

}

//
//  UserMO+CoreDataProperties.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 23/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO");
    }

    @NSManaged public var birthday: NSDate?
    @NSManaged public var identifier: String
    @NSManaged public var name: String?
    @NSManaged public var username: String?

}

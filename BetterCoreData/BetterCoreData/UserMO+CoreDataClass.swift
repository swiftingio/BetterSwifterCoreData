//
//  UserMO+CoreDataClass.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 23/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import Foundation
import CoreData


public class UserMO: NSManagedObject {}

extension UserMO: ManagedObjectProtocol {
    func toEntity() -> User? {
        return User(id: identifier, username: username, name: name, birthday: birthday as Date?)
    }
}

extension User: ManagedObjectConvertible {
    func toManagedObject(in context: NSManagedObjectContext) -> UserMO? {
        let user = UserMO.getOrCreateSingle(with: id, from: context)
        user.birthday = birthday as NSDate?
        user.name = name
        user.username = username
        return user
    }
}

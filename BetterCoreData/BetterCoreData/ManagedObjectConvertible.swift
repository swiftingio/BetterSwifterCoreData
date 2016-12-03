//
//  ManagedObjectConvertible.swift
//  Created by swifting.io Team
//

import CoreData

protocol ManagedObjectConvertible {
    associatedtype ManagedObject: NSManagedObject, ManagedObjectProtocol
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}

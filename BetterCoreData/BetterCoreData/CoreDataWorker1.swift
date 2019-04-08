//
//  CoreDataWorker1.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 23/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import CoreData

protocol CoreDataWorkerProtocol {
    associatedtype EntityType
    func get(with predicate: NSPredicate?,
             sortDescriptors: [NSSortDescriptor]?,
             fetchLimit: Int?,
             completion: @escaping (Result<[EntityType], Error>) -> Void)
    func upsert(entities: [EntityType],
                completion: @escaping (Error?) -> Void)
}

extension CoreDataWorkerProtocol {
    func get(with predicate: NSPredicate? = nil,
             sortDescriptors: [NSSortDescriptor]? = nil,
             fetchLimit: Int? = nil,
             completion: @escaping (Result<[EntityType], Error>) -> Void){
        get(with: predicate,
            sortDescriptors: sortDescriptors,
            fetchLimit: fetchLimit,
            completion: completion)
    }
}

enum CoreDataWorkerError: Error{
    case cannotFetch(String)
    case cannotSave(Error)
}

class CoreDataWorker<ManagedEntity, Entity>: CoreDataWorkerProtocol where
    ManagedEntity: NSManagedObject,
    ManagedEntity: ManagedObjectProtocol,
Entity: ManagedObjectConvertible {
    
    let coreData: CoreDataServiceProtocol
    init(coreData: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreData = coreData
    }
    
    func get(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?,
             completion: @escaping (Result<[Entity], Error>) -> Void) {
        
        coreData.performForegroundTask { (context) in
            do {
                let fetchRequest = ManagedEntity.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                let results = try context.fetch(fetchRequest) as? [ManagedEntity]
                let items: [Entity] = results?.compactMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
    
    func upsert(entities: [Entity], completion: @escaping (Error?) -> Void) {
        coreData.performBackgroundTask { (context) in
            _ = entities.compactMap({ (entity) -> ManagedEntity? in
                return entity.toManagedObject(in: context) as? ManagedEntity
            })
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(CoreDataWorkerError.cannotSave(error))
            }
        }
    }
    
    // other methods: remove, ...
}

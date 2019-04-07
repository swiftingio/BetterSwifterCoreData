//
//  UserDataController.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 26/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import Foundation

protocol UserDataControllerProtocol {
    func fetchUser(completion: @escaping (User?) -> Void)
    func updateUser(name: String?, username: String?)
}

class UserDataController: UserDataControllerProtocol {
    let worker: CoreDataWorker<UserMO, User>
    private var currentUser: User?
    
    init(worker: CoreDataWorker<UserMO, User> = CoreDataWorker<UserMO, User>()){
        self.worker = worker
    }
    
    func fetchUser(completion: @escaping (User?) -> Void) {
        worker.get{ [weak self](result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                self?.currentUser = users.first
                completion(users.first)
            case .failure(let error):
                print("\(error)")
                completion(nil)
            }
        }
    }
    
    func updateUser(name: String?, username: String?){
        var user: User = currentUser ?? User(id: UUID().uuidString)
        user.name = name
        user.username = username
        worker.upsert(entities: [user]){ (error) in
            guard let error = error else { return }
            print("\(error)")
        }
    }
}

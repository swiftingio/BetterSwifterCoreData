//
//  User.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 23/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import Foundation

struct User {
    let id: String
    var username: String?
    var name: String?
    var birthday: Date?
}

extension User {
    init(id: String){
        self.id = id
        self.username = nil
        self.name = nil
        self.birthday = Date()
    }
}

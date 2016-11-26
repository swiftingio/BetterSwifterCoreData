//
//  Result.swift
//  BetterCoreData
//
//  Created by Michal Wojtysiak on 23/11/2016.
//  Copyright © 2016 Michal Wojtysiak. All rights reserved.
//

import Foundation
enum Result<T>{
    case success(T)
    case failure(Error)
}


//
//  User.swift
//  RealRacing
//
//  Created by Родион Ковалевский on 12/16/19.
//  Copyright © 2019 Родион Ковалевский. All rights reserved.
//

import Foundation
class User{
    var name:String?
    var record:Int? = 0
    init (name:String?,record:Int?){
        self.name = name
        self.record = record
    }
}

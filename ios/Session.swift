//
//  Session.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

public struct Session {
    static var shared = Session()
    
    var user: User?
    
    public mutating func setLoggedInUser(user: User) {
        self.user = user
    }
    
    public func getLoggedInUser() -> User? {
        return self.user ?? nil
    }
}

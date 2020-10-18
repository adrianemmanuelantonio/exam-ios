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
    
    var profile: Profile?
    
    public mutating func setUserProfile(profile: Profile) {
        self.profile = profile
    }
    
    public func getUserProfile() -> Profile? {
        return self.profile ?? nil
    }
}

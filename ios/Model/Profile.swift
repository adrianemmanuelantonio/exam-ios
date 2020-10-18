//
//  Profile.swift
//  ios
//
//  Created by Adrian on 10/18/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

public struct Profile: Codable {
    let id, firstName, lastName, mobile, referral_code: String
    let is_verified: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case mobile
        case is_verified
        case referral_code
    }
}

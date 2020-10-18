//
//  ProfileModel.swift
//  ios
//
//  Created by Adrian on 10/18/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

public struct ProfileModel: Codable {
    let status: Int
    let message: String
    let data: DataNode?
}

public struct DataNode: Codable {
    let user: Profile
}

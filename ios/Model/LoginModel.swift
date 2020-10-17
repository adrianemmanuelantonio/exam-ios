//
//  LoginModel.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

public struct LoginModel: Codable {
    let status: Int
    let message: String
    let data: DataClass?
}

public struct DataClass: Codable {
    let user: User
}

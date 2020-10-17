//
//  RewardsModel.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

public struct RewardsModel: Codable {
    let status: Int
    let message: String
    let data: DataList
}

public struct DataList: Codable {
    let list: [Reward]
}

// MARK: - List
public struct Reward: Codable {
    let id: Int
    let name, listDescription: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case listDescription = "description"
        case image
    }
}

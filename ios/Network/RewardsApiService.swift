//
//  RewardsApiService.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

public class RewardsApiService {
    public static let shared = RewardsApiService()
    
    public func requestRewards(completion: @escaping ([Reward]?) -> ()) {
        // TODO: Transfer to api request when api is given
        // Please refer to rewards.json file in the root of project
        let filePath = Bundle.main.url(forResource: "rewards", withExtension: "json")
        let originalContents = try? Data(contentsOf: filePath!)
        
        if let rewards = try? JSONDecoder().decode(RewardsModel.self, from: originalContents!) {
            completion(rewards.data.list)
        } else {
            completion(nil)
        }
    }
}

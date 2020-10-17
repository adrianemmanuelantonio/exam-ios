//
//  DashboardViewModel.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

protocol DashboardViewModelProtocol {
    var rewardsReceived: (() -> Void)? { get set }
}

class DashboardViewModel: DashboardViewModelProtocol {
    var rewardsReceived: (() -> Void)?
    var user: User!
    var rewards: [Reward]?
    
    init(user: User) {
        self.user = user
    }
    
    public func getName() -> String {
        return "\(user.firstName) \(user.lastName)"
    }
    
    public func getMobileNumber() -> String  {
        return user.mobile
    }
    
    public func getReferralCode() -> String {
        return "TODO:CODE"
    }
    
    public func requestRewards() {
        guard let completion = rewardsReceived else {
            return
        }
        
        RewardsApiService.shared.requestRewards() { (response) in
            if let rewards = response {
                self.rewards = rewards
                completion()
            } else {
                print("No rewards")
            }
        }
    }
    
    public func getRewardsCount() -> Int {
        return rewards?.count ?? 0
    }
    
    public func getReward(index: Int) -> Reward? {
        return rewards?[index] ?? nil
    }
}

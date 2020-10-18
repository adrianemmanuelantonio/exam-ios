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
    var profile: Profile!
    var rewards: [Reward]?
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    public func getName() -> String {
        return "\(profile.firstName) \(profile.lastName)"
    }
    
    public func getMobileNumber() -> String  {
        return profile.mobile
    }
    
    public func getReferralCode() -> String {
        return profile.referral_code
    }
    
    public func requestRewards() {
        guard let completion = rewardsReceived else {
            return
        }
        
        RewardsApiService.shared.requestRewards() { (response) in
            if let rewards = response {
                self.rewards = rewards
                completion()
            }
        }
    }
    
    public func getRewardsCount() -> Int {
        return rewards?.count ?? Constants.Generic.Zero
    }
    
    public func getReward(index: Int) -> Reward? {
        return rewards?[index] ?? nil
    }
}

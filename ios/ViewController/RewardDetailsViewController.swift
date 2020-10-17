//
//  RewardDetailsViewController.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class RewardDetailsViewController: UIViewController {
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var rewardNameTxt: UILabel!
    @IBOutlet weak var rewardDescriptionTxt: UILabel!
    
    var selectedReward: Reward?

    override func viewDidLoad() {
        super.viewDidLoad()

        showRewardDetails()
    }
    
    private func showRewardDetails() {
        guard let reward = selectedReward else {
            return
        }
        
        rewardImage.download(from: reward.image)
        rewardNameTxt.text = reward.name
        rewardDescriptionTxt.text = reward.listDescription
    }

}

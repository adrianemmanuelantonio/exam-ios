//
//  RewardCell.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class RewardCell: UITableViewCell {
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var rewardNameTxt: UILabel!
    
    public func setupDetails(reward: Reward) {
        self.rewardNameTxt.text = reward.name
        self.rewardImage.image = nil
        self.rewardImage.download(from: reward.image)
    }

    class func createCell() -> RewardCell? {
        let nib = UINib(nibName: "RewardCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).last as? RewardCell
        
        return cell
    }
}

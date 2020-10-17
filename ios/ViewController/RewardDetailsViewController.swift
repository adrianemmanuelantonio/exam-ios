//
//  RewardDetailsViewController.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class RewardDetailsViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var rewardNameTxt: UILabel!
    @IBOutlet weak var rewardDescriptionTxt: UILabel!
    
    var selectedReward: Reward?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.showRewardDetails()
        self.setupShareButton()
    }
    
    private func setupShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareBtnAction))
    }
    
    @objc private func shareBtnAction() {
        guard let image = rewardImage.image else {
            Prompt.show(controller: self, message: "Failed to share")
            return
        }

        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        self.present(activityViewController, animated: true, completion: nil)
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

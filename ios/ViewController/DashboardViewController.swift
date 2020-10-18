//
//  HomeViewController.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var mobileTxt: UILabel!
    @IBOutlet weak var codeTxt: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var profile: Profile!
    private var viewModel: DashboardViewModel?
    private var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
        if let destination = segue.destination as? RewardDetailsViewController {
            if let reward = viewModel?.getReward(index: selectedIndex!) {
                destination.selectedReward = reward
            }
        }
    }
    
    private func setupViewModel() {
        if let profile = Session.shared.getUserProfile() {
            viewModel = DashboardViewModel(profile: profile)
            setupDetails()
            setupObservers()
            requestRewards()
        }
    }
    
    private func setupDetails() {
        guard let model = viewModel else {
            return
        }
        
        nameTxt.text = model.getName()
        mobileTxt.text = model.getMobileNumber()
        codeTxt.text = model.getReferralCode()
    }
    
    private func requestRewards() {
        guard let model = viewModel else {
            return
        }
        
        model.requestRewards()
    }
    
    private func setupObservers() {
        guard let model = viewModel else {
            return
        }
        
        model.rewardsReceived = {
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel else {
            return 0
        }
        return model.getRewardsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell") as? RewardCell
        if cell == nil {
            cell = RewardCell.createCell()
        }
        
        if let model = viewModel {
            if let reward = model.getReward(index: indexPath.row) {
                cell?.setupDetails(reward: reward)
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: Constants.SegueIdentifiers.segueDetails, sender: nil)
    }
}

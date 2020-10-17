//
//  HomeViewController.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Session.shared.getLoggedInUser() {
            self.user = user
        }
        
        print(user.firstName)
    }

}

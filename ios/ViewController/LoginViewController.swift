//
//  LoginViewController.swift
//  ios
//
//  Created by MBAS on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.SegueIdentifiers.segueHome, sender: nil)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

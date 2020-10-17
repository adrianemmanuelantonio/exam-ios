//
//  RootViewController.swift
//  ios
//
//  Created by MBAS on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LoginViewController {
            destination.modalPresentationStyle = .fullScreen
        }
        if let destination = segue.destination as? RegisterViewController {
            destination.modalPresentationStyle = .fullScreen
        }
    }

    @IBAction func loginBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.SegueIdentifiers.segueLogin, sender: nil)
    }
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.SegueIdentifiers.segueRegister, sender: nil)
    }
}

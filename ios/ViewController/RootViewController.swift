//
//  RootViewController.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LoginViewController {
            destination.modalPresentationStyle = .fullScreen
        }
        if let destination = segue.destination as? RegisterViewController {
            destination.modalPresentationStyle = .fullScreen
        }
    }

    @IBAction func loginBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.SegueIdentifiers.SegueLogin, sender: nil)
    }
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.SegueIdentifiers.SegueRegister, sender: nil)
    }
}

//
//  LoginViewController.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var pinTxt: UITextField!
    
    private let MOBILE_NUMBER_TAG = 0
    private let MPIN_TAG = 1
    
    let viewModel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupFieldDelegates()
        self.setupViewModelObserver()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .fullScreen
    }
    
    private func setupFieldDelegates() {
        self.mobileNumberTxt.delegate = self
        self.mobileNumberTxt.tag = MOBILE_NUMBER_TAG
        self.pinTxt.delegate = self
        self.pinTxt.tag = MPIN_TAG
    }
    
    private func setupViewModelObserver() {
        self.viewModel.apiResponse = { (message, response) in
            if let user = response {
                self.viewModel.getProfile(mobileNumber: user.mobile)
            } else {
                Prompt.show(controller: self, message: message)
            }
        }
        
        self.viewModel.getProfileResponse = { (response, message) in
            if let profile = response {
                Session.shared.setUserProfile(profile: profile)
                self.performSegue(withIdentifier: Constants.SegueIdentifiers.segueHome, sender: nil)
            } else {
                Prompt.show(controller: self, message: message)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == Constants.Generic.One { // Allowing backspace
            return true;
        }
        
        guard let targetTextfieldCount = textField.text?.count  else {
            return false
        }
        
        switch textField.tag {
        case MOBILE_NUMBER_TAG:
            if targetTextfieldCount >= Constants.Validations.mobileNumberLength {
                return false
            }
        case MPIN_TAG:
            if targetTextfieldCount >= Constants.Validations.mpinLength {
                return false
            }
        default:
            break
        }
        return true
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        guard let mobileNumber = mobileNumberTxt.text, !mobileNumber.trimmingCharacters(in: .whitespaces).isEmpty else {
            Prompt.show(controller: self, message: "Mobile Number is required")
            return
        }
        
        if !mobileNumber.isValidMobileNumber {
            Prompt.show(controller: self, message: "Invalid Mobile Number should be 09XXXXXXXXX")
            return
        }
        
        guard let mPin = pinTxt.text, !mPin.trimmingCharacters(in: .whitespaces).isEmpty else {
            Prompt.show(controller: self, message: "MPIN is required")
            return
        }
        
        if mPin.count != Constants.Validations.mpinLength {
            Prompt.show(controller: self, message: "MPIN should be 4 characters")
            return
        }
        
        self.viewModel.login(mobileNumber: mobileNumber, mPin: mPin)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

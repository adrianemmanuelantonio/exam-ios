//
//  RegisterViewController.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var pinTxt: UITextField!
    @IBOutlet weak var pinToggleBtn: UIButton!
    @IBOutlet weak var confirmPinTxt: UITextField!
    @IBOutlet weak var confirmPinToggleBtn: UIButton!
    
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
        self.mobileNumberTxt.tag = Constants.Tags.MobileNumberFieldTag
        self.pinTxt.delegate = self
        self.pinTxt.tag = Constants.Tags.MPINFieldTag
        self.confirmPinTxt.delegate = self
        self.confirmPinTxt.tag = Constants.Tags.MPINFieldTag
    }
    
    private func setupViewModelObserver() {
        self.viewModel.registerSuccessResponse = { (message) in
            self.requestProfile()
        }
        
        self.viewModel.registerFailedResponse = { (message) in
            Prompt.show(controller: self, message: message)
        }
        
        self.viewModel.getProfileResponse = { (response, message) in
            if let profile = response {
                Session.shared.setUserProfile(profile: profile)
                self.performSegue(withIdentifier: Constants.SegueIdentifiers.SegueHome, sender: nil)
            } else {
                Prompt.show(controller: self, message: message)
            }
        }
    }
    
    private func requestProfile() {
        if let mobileNumber = self.mobileNumberTxt.text?.trimmingCharacters(in: .whitespaces) {
            self.viewModel.getProfile(mobileNumber: mobileNumber)
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
        case Constants.Tags.MobileNumberFieldTag:
            if targetTextfieldCount >= Constants.Validations.MobileNumberLength {
                return false
            }
        case Constants.Tags.MPINFieldTag:
            if targetTextfieldCount >= Constants.Validations.MPINLength {
                return false
            }
        default:
            break
        }
        return true
    }

    @IBAction func registerBtnAction(_ sender: UIButton) {
        guard let firstName = firstNameTxt.text, !firstName.trimmingCharacters(in: .whitespaces).isEmpty else {
            Prompt.show(controller: self, message: "First Name is required")
            return
        }
        
        guard let lastName = lastNameTxt.text, !lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            Prompt.show(controller: self, message: "Last Name is required")
            return
        }
        
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
        
        if mPin.count != Constants.Validations.MPINLength {
            Prompt.show(controller: self, message: "MPIN should be 4 characters")
            return
        }
        
        guard let confirmMpin = confirmPinTxt.text, !confirmMpin.trimmingCharacters(in: .whitespaces).isEmpty else {
            Prompt.show(controller: self, message: "Confirm MPIN is required")
            return
        }
        
        if mPin != confirmMpin {
            Prompt.show(controller: self, message: "MPIN do not match")
            return
        }
        
        viewModel.register(firstName: firstName, lastName: lastName, mobile: mobileNumber, mpin: mPin)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pinToggleAction(_ sender: UIButton) {
        pinTxt.isSecureTextEntry = !pinTxt.isSecureTextEntry
        pinToggleBtn.setTitle((pinTxt.isSecureTextEntry ? "Show" : "Hide"), for: .normal)
    }
    
    @IBAction func confirmPinToggleAction(_ sender: Any) {
        confirmPinTxt.isSecureTextEntry = !confirmPinTxt.isSecureTextEntry
        confirmPinToggleBtn.setTitle((confirmPinTxt.isSecureTextEntry ? "Show" : "Hide"), for: .normal)
    }
}

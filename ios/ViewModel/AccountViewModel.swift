//
//  LoginViewModel.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

protocol AccountViewModelProtocol {
    var apiResponse: ((String, User?) -> Void)? { get set }
}

class AccountViewModel: AccountViewModelProtocol {
    var apiResponse: ((String, User?) -> Void)?
    var registerSuccessResponse: ((String) -> Void)?
    var registerFailedResponse: ((String) -> Void)?
    var getProfileResponse: ((Profile?, String) -> Void)?
    
    func login(mobileNumber: String, mPin: String) {
        guard let completion = apiResponse else {
            return
        }
        
        let parameters: [String: String] = [
            "mobile": mobileNumber,
            "mpin": mPin
        ]
        
        AccountApiService.shared.login(parameters: parameters) { (resp) in
            guard let response = resp else {
                completion("Failed to login", nil)
                return
            }
            
            if response.status != 200 {
                completion(response.message, nil)
                return
            }
            
            if let data = response.data {
                completion(response.message, data.user)
            }
        }
    }
    
    func register(firstName: String, lastName: String, mobile: String, mpin: String) {
        guard let success = registerSuccessResponse else {
            return
        }
        
        guard let failed = registerFailedResponse else {
            return
        }
        
        let parameters: [String: String] = [
            "first_name": firstName,
            "last_name": lastName,
            "mobile": mobile,
            "mpin": mpin
        ]
        
        AccountApiService.shared.register(parameters: parameters) { (status, message) in
            if status == 200 {
                success(message)
            } else {
                failed(message)
            }
        }
    }
    
    func getProfile(mobileNumber: String) {
        guard let completion = getProfileResponse else {
            return
        }
        
        let parameters: [String: String] = [
            "mobile": mobileNumber
        ]
        
        AccountApiService.shared.getProfile(parameters: parameters) { (response, message) in
            guard let profile = response else {
                completion(nil, message)
                return
            }
            
            completion(profile, message)
        }
    }
}

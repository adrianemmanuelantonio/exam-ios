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
}

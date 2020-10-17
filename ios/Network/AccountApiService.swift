//
//  AccountApiService.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

public class AccountApiService {
    static let shared = AccountApiService()
    
    public func login(parameters: [String: String], completion: @escaping (LoginModel?) -> ()) {
        // TODO: Replace this sample json response once api is finished
        let successfulJsonResponse = "{" +
            "\"status\": 200," +
            "\"message\": \"Successfully logged in.\"," +
            "\"data\": {" +
                "\"user\": {" +
                    "\"id\": \"123-456-789-abc-def\"," +
                    "\"first_name\": \"John\"," +
                    "\"last_name\": \"Doe\"," +
                    "\"mobile\": \"9123456789\"" +
                "}" +
            "}" +
        "}"
        
        let failedJsonResponse = "{" +
            "\"status\": 404," +
            "\"message\": \"User not found.\"," +
            "\"data\": null" +
        "}"

        // Toggle the appropriate hardcoded json string for now
        let jsonData = successfulJsonResponse.data(using: .utf8)
        if let loginResponse = try? JSONDecoder().decode(LoginModel.self, from: jsonData!) {
            completion(loginResponse)
        } else {
            completion(nil)
        }
    }
    
    public func register(parameters: [String: String], completion: @escaping (Int, String) -> ()) {
        // TODO: Replace this sample json response once api is finished
        let successfulJsonResponse = "{" +
            "\"status\": 200," +
            "\"message\": \"Successfully registered!\"," +
            "\"data\": null" +
        "}"
        
        let failedJsonResponse = "{" +
            "\"status\": 404," +
            "\"message\": \"Please fill up required fields.\"," +
            "\"data\": null" +
        "}"
        
        // Toggle the appropriate hardcoded json string for now
        let jsonData = successfulJsonResponse.data(using: .utf8)
        if let loginResponse = try? JSONDecoder().decode(LoginModel.self, from: jsonData!) {
            completion(loginResponse.status, loginResponse.message)
        } else {
            completion(500, "Failed to register")
        }
    }
}

//
//  Constants.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

struct Constants {
    struct Generic {
        static let Zero = 0
        static let One = 1
    }
    
    struct SegueIdentifiers {
        static let SegueLogin = "segueLogin"
        static let SegueRegister = "segueRegister"
        static let SegueHome = "segueHome"
        static let SegueDetails = "segueDetails"
    }
    
    struct Validations {
        static let MobileNumberLength = 11
        static let MPINLength = 4
    }
    
    struct Tags {
        static let MobileNumberFieldTag = 0
        static let MPINFieldTag = 1
    }
    
    struct ApiCodes {
        static let Success = 200
        static let ServerError = 500
    }
}

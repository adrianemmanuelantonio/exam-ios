//
//  String+Validations.swift
//  ios
//
//  Created by Adrian on 10/17/20.
//  Copyright © 2020 Adrian Antonio. All rights reserved.
//

import Foundation

extension String {
    var isValidMobileNumber: Bool {
        let mobileNumberRegex = "^[09]{2}[0-9]{9}$"

        let mobilePred = NSPredicate(format:"SELF MATCHES %@", mobileNumberRegex)
        return mobilePred.evaluate(with: self)
    }
}

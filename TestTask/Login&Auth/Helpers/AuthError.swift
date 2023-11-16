//
//  AuthError.swift
//  TestTask
//
//  Created by Шахова Анастасия on 03.11.2023.
//

import Foundation
import UIKit

enum AuthError {
    case notFilled
    case invalidEmail
    case invalidPassword
    case unknownUser
    case unknownError
    case dublicate
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill in all the fields", comment: "Please enter all fields.")
        case .invalidEmail:
            return NSLocalizedString("Invalid Email", comment: "Please enter a valid email.")
        case .invalidPassword:
            return NSLocalizedString("Invalid Password.The password must contain one capital letter, one line, a special character and a number. Minimum password length 6 characters", comment: "Please enter a valid email.")
        case .unknownUser:
            return NSLocalizedString("User is not found", comment: "Please check the entered data")
        case .unknownError:
            return NSLocalizedString("Error", comment: "")
        case .dublicate:
            return NSLocalizedString("User is already registered", comment: "")
        }
    }
}


//
//  Validators.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation

class Validators {
    static func isFilled(email: String?, password: String?) -> Bool {
        guard let password = password,
              let email = email,
              password != "",
              email != "" else {
            return false
            
        }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
    static func isCorrectPassword(_ password: String) -> Bool {
        //least one uppercase, digit, lowercase,special symbol,min 6 character
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{\(6),}$"
        return check(text: password, regEx: passwordRegEx)
    }
    
    static func rightPassword(writePassword: String, readPassword: String) -> Bool {
        return readPassword == writePassword ? true : false
    }
}


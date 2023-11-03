//
//  AlertExtension.swift
//  TestTask
//
//  Created by Шахова Анастасия on 03.11.2023.
//

import Foundation
import UIKit

class AlertManager {

    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

// MARK: - Login Errors
extension AlertManager {

    public static func showLoginErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Login Error", message: nil)
    }

    public static func showLoginErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Login Error", message: "\(error.localizedDescription)")
    }
}

// MARK: - Registration Errors
extension AlertManager {

    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Registration Error", message: nil)
    }

    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Registration Error", message: "\(error.localizedDescription)")
    }
}

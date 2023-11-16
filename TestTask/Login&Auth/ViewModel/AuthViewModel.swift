//
//  AuthViewModel.swift
//  TestTask
//
//  Created by Шахова Анастасия on 03.11.2023.
//

import Foundation

class AuthViewModel {
    weak var coordinator : AppCoordinator?
    
    private var credentials = Credentials() {
        didSet {
            username = credentials.username
            password = credentials.password
        }
    }
    
    private var username = ""
    private var password = ""
    
    var errorMessage: Dynamic<Error?> = Dynamic(nil)
    
    func updateCredentials(username: String, password: String, otp: String? = nil) {
        credentials.username = username
        credentials.password = password
    }
    
    func login(completion: @escaping(String) -> ()) {
        AuthService.shared.register(email: username, password: password) { [weak self] (result) in
            switch result {
            case .success(_):
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
                UserDefaults.standard.synchronize()
                completion("success")
                
            case .failure(let error):
                self?.errorMessage.value = error
                completion("unsuccess")
            }
        }
    }
    
    func goToLoginPage() {
        coordinator?.goToLoginPage()
    }
    
    func goToMainPage() {
        coordinator?.goToMainPage()
    }
}

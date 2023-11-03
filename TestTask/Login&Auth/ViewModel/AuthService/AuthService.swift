//
//  AuthService.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    func login(email: String?, password: String?, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        guard Validators.isFilled(email: email, password: password) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        do {
            let data = try KeyChainManager.getPassword(email: email)
            let readPassword = String(decoding: data ?? Data(), as: UTF8.self)
            
            guard Validators.rightPassword(writePassword: password, readPassword: readPassword) else {
                completion(.failure(AuthError.unknownUser))
                return
            }
            
            completion(.success(password))
            
        } catch {
            completion(.failure(AuthError.unknownUser))
        }
    }
    
    func register(email: String?, password: String?, completion: @escaping (Result<String, Error>) -> Void) {
    
        guard let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard Validators.isFilled(email: email, password: password) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        guard Validators.isCorrectPassword(password) else {
            completion(.failure(AuthError.invalidPassword))
            return
        }
        
        do {
            try KeyChainManager.save(password: password.data(using: .utf8) ?? Data(), email: email)
            completion(.success(email))
        } catch {
            completion(.failure(AuthError.dublicate))
        }
    }
}

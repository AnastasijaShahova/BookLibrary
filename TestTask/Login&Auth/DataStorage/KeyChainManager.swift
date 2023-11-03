//
//  KeyChainManager.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation

enum KeyChainError: Error {
    case duplicateItem
    case unkknown(status: OSStatus)
}

final class KeyChainManager {
    static func save(password: Data, email: String) throws {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: email,
            kSecValueData: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeyChainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeyChainError.unkknown(status: status)
        }
    }
    
    static func getPassword(email: String) throws -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: email,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeyChainError.unkknown(status: status)
        }
        
        return result as? Data
    }
}

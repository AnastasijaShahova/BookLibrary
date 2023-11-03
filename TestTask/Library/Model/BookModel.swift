//
//  BookModel.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import Foundation

struct Library: Decodable {
    let books: [Book]
    
    enum CodingKeys: String, CodingKey {
        case books = "hydra:member"
    }
}

struct Book: Decodable {
    let title: String
    let author: String
    let rating: Int?
}


//
//  BookInfoCellViewModel.swift
//  TestTask
//
//  Created by Шахова Анастасия on 02.11.2023.
//

import Foundation

class BookInfoCellViewModel {
    private var bookInfo: Book
    
    init(bookInfo: Book) {
        self.bookInfo = bookInfo
    }
    
    var title: String {
        return bookInfo.title
    }
    
    var author: String {
        return bookInfo.author
    }
    
    var rating: String {
        guard let rating = bookInfo.rating else { return ""}
        return String(describing: rating)
    }
}


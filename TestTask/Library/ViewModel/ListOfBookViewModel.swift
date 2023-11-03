//
//  ListOfBookViewModel.swift
//  TestTask
//
//  Created by Шахова Анастасия on 02.11.2023.
//

import Foundation

class ListOfBookViewModel {

    private var library: [Book]?

    func fetchLibrary(completion: @escaping() -> ()) {
        NetworkManager.fetchData { [weak self] library, error in
            guard let library = library else { return }
            self?.library = library
            completion()
        }
    }

    func numberOfRowsInSection() -> Int {
        return library?.count ?? 0
    }

    func cellViewModelForIndexPath(indexPath: IndexPath) -> BookInfoCellViewModel? {
        guard let book = library?[indexPath.row] else { return nil }
        return BookInfoCellViewModel(bookInfo: book)
    }
}

//
//  NetworkManager.swift
//  TestTask
//
//  Created by Шахова Анастасия on 02.11.2023.
//

import Foundation
import Moya

class NetworkManager {
    static func fetchData(completion: @escaping ([Book]?, MoyaError?) -> Void) {
        let provider = MoyaProvider<BookService>()

        provider.request(.books) { result in
            switch result {
            case let .success(booksResponse):
                do {
                    let filteredResponse = try booksResponse.filterSuccessfulStatusCodes()
                    let library = try filteredResponse.map(Library.self)
                    completion(library.books, nil)
                }
                catch let error as NSError {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}

enum BookService {
    case books
}

extension BookService: TargetType {
    var baseURL: URL { URL(string: "https://demo.api-platform.com/books?page=1")! }
    
    var path: String {
        switch self {
        case .books:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .books:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .books:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

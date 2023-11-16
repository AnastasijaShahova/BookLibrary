//
//  Coordinator.swift
//  TestTask
//
//  Created by Шахова Анастасия on 16.11.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

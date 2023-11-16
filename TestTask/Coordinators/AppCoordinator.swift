//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Шахова Анастасия on 16.11.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController = UINavigationController()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        if isAuthenticated {
            goToMainPage()
        } else {
            goToLoginPage()
        }
    }
    
    func goToLoginPage() {
        let loginViewController = LoginViewController()
        let loginViewModel = LoginViewModel()
        loginViewModel.coordinator = self
        loginViewController.viewModel = loginViewModel
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func goToRegisterPage() {
        let authViewController = SignUpViewController()
        let authViewModel = AuthViewModel()
        authViewModel.coordinator = self
        authViewController.viewModel = authViewModel
        navigationController.pushViewController(authViewController, animated: true)
    }
    
    func goToMainPage() {
        let mainViewController = ListOfBooksViewController()
        let mainViewModel = ListOfBookViewModel()
        mainViewModel.coordinator = self
        mainViewController.viewModel = mainViewModel
        navigationController.pushViewController(mainViewController, animated: true)
    }
}

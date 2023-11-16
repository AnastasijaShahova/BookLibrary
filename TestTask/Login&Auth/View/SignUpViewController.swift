//
//  SignUpViewController.swift
//  TestTask
//
//  Created by Шахова Анастасия on 02.11.2023.
//

import Foundation
import UIKit

final class SignUpViewController: UIViewController {
    
    var viewModel: AuthViewModel?
    
    let welcomeLabel = UILabel(text: "Register your user!", font: .avenir26())
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .black, cornerRadius: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupConstraints()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        bindData()
    }
    
    @objc private func signUpButtonTapped() {
        viewModel?.updateCredentials(username: emailTextField.text!, password: passwordTextField.text!)
        
        viewModel?.login(completion: { [weak self] (value) in
            if value == "success" {
                self?.viewModel?.goToMainPage()
            }
        })
    }
    
    func bindData() {
        viewModel?.errorMessage.bind {
            guard let errorMessage = $0 else { return }
            AlertManager.showRegistrationErrorAlert(on: self, with: errorMessage )
        }
    }
    
}

// MARK: - setConstraint
extension SignUpViewController {
    private func setupConstraints() {
        
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
            emailStackView,
            passwordStackView,
            signUpButton
        ], axis: .vertical, spacing: 40)
        
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - textFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

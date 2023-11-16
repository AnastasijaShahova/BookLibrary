//
//  ViewController.swift
//  TestTask
//
//  Created by Шахова Анастасия on 01.11.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private var viewModel: LoginViewModel?
    
    let welcomeBackLabel = UILabel(text: "Welcome!", font: .avenir26())
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .black)
    let needAnAccountLabel = UILabel(text: "Need an account?")
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        viewModel = LoginViewModel()
        
        setupConstraints()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        if isAuthenticated {
            navigationController?.pushViewController(ListOfBooksViewController(), animated: true)
        }
        cleanTextField()
    }
    
    private func cleanTextField() {
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    @objc private func loginButtonTapped() {
        viewModel?.updateCredentials(username: emailTextField.text!, password: passwordTextField.text!)
        
        viewModel?.login(completion: { value in
            if value == "success" {
                let libraryViewController = ListOfBooksViewController()
                self.navigationController?.pushViewController(libraryViewController, animated: true)
            }
        })
    }
    
    func bindData() {
        viewModel?.errorMessage.bind {
            guard let errorMessage = $0 else { return }
            AlertManager.showLoginErrorAlert(on: self, with: errorMessage )
        }
    }
    
    @objc private func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}

// MARK: - setConstraint
extension LoginViewController {
    private func setupConstraints() {
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, loginButton], axis: .vertical, spacing: 40)
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton],
                                          axis: .horizontal,
                                          spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        welcomeBackLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        
        view.addSubview(welcomeBackLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeBackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeBackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeBackLabel.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
}

// MARK: - textFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
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

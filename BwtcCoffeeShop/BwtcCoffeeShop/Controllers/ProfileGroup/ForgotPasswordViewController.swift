//
//  ForgotPasswordViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 21.03.2024.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    let emailField = UITextField()
    let buttonForgotPassword = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createNavionItem()
        createEmailField()
        createButton()
    }
    
    func createNavionItem() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.setupNavBarColor()
        let logoImageItem = "Відновлення пароля"
        navigationItem.title = logoImageItem
    }
    
    func createEmailField() {
        view.addSubview(emailField)
        emailField.updateTextFields(placeholder: "Електронна адреса", view: self.view)
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
        ])
    }
    
    func createButton() {
        view.addSubview(buttonForgotPassword)
        buttonForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        buttonForgotPassword.customButton(title: "Відновити", view:  self.view)
        buttonForgotPassword.addTarget(self, action: #selector( didTabForgotPassword), for: .touchUpInside)
        NSLayoutConstraint.activate([
            buttonForgotPassword.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
        ])
    }
    
    @objc private func didTabForgotPassword() {
        let email = self.emailField.text ?? ""
        if !Validator.isValidEmail(for: email) {
            AlertManager.shared.showInvalidEmailAlert(vc: self)
            return
        }
        AuthService.shared.forgotPassword(with: email) { [weak self]  error in
            guard let self = self else {return}
            if let error = error {
              AlertManager.shared.showErrorSendingPasswordReset(vc: self, error: error)
                return
            }
            AlertManager.shared.showPasswordResetSent(vc: self)
        }
    }
    
}


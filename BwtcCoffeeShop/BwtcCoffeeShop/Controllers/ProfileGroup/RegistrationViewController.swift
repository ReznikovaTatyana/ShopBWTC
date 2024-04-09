//
//  RegistrationViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 03.03.2024.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore


class RegistrationViewController: UIViewController {
    
    //let registrationLabel = UILabel()
    let surnameTextField = UITextField()
    let nameTextField = UITextField()
    let phoneTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registrationButton = UIButton()
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
    }
    
    private func setupView() {
        view.addSubview(surnameTextField)
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registrationButton)
       // view.addSubview(registrationLabel)
        nav()
        createSurnameTextField()
        createRegistrationButton()
       // createRegistrationLabel()
        makeConstraints()
        
    }
    func nav() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.setupNavBarColor()
        let logoImageItem = "Реєстрація"
        navigationItem.title = logoImageItem
    }
    
    private func createSurnameTextField() {
        surnameTextField.updateTextFields(placeholder: "Прізвище", view: self.view)
        nameTextField.updateTextFields(placeholder: "Ім'я", view:  self.view)
        phoneTextField.updateTextFields(placeholder: "Мобільний телефон", view:  self.view)
        emailTextField.updateTextFields(placeholder: "Ел.пошта", view:  self.view)
        passwordTextField.updateTextFields(placeholder:  "Пароль", view:  self.view)
    }
    
    
    
    private func createRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.customButton(title: "Зареєструватися", view: self.view)
        registrationButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
    }
    

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            surnameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            nameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            
            phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            
            registrationButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30)
        ])
    }
    
    @objc func registrationButtonAction() {
        let registerUserRequest = RegisterUser(firstUserName: nameTextField.text ?? "", lastUserName: surnameTextField.text ?? "", email: emailTextField.text ?? "", phone: phoneTextField.text ?? "", password: passwordTextField.text ?? "")
        
        if !Validator.isValidUserName(for: registerUserRequest.firstUserName) {
            AlertManager.shared.showInvalidUsernameAlert(vc: self)
            return
        }
        
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.shared.showInvalidEmailAlert(vc: self)
            return
        }
        
        if !Validator.isValidPassword(for: registerUserRequest.password) {
            AlertManager.shared.showInvalidPasswordAlert(vc: self)
            return
        }
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.shared.showRegistrationErrorAlert(on: self,with: error)
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {

                }
            } else {
                AlertManager.shared.showRegistrationErrorAlert(on: self)
            }
        }

        print(registerUserRequest)
    }
    
}



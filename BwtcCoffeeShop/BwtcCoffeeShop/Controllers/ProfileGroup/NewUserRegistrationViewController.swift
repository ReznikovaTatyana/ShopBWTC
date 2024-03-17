//
//  NewUserRegistrationViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 03.03.2024.
//

import UIKit

class NewUserRegistrationViewController: UIViewController {
    
    let registrationLabel = UILabel()
    let surnameTextField = UITextField()
    let nameTextField = UITextField()
    let numberTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registrationButton = UIButton()
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        view.addSubview(surnameTextField)
        view.addSubview(nameTextField)
        view.addSubview(numberTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registrationButton)
        view.addSubview(registrationLabel)
        createSurnameTextField()
        createRegistrationButton()
        createRegistrationLabel()
        makeConstraints()
        
    }
    
    private func createSurnameTextField() {
        surnameTextField.placeholder = "Прізвище"
        nameTextField.placeholder = "Ім'я"
        numberTextField.placeholder = "Мобільний телефон"
        emailTextField.placeholder = "Ел.пошта"
        passwordTextField.placeholder = "Пароль"
        updateTextFields(textField: surnameTextField)
        updateTextFields(textField: nameTextField)
        updateTextFields(textField: numberTextField)
        updateTextFields(textField: emailTextField)
        updateTextFields(textField: passwordTextField)
        
    }
    
    private func updateTextFields(textField: UITextField) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.textColor = .black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.borderStyle = .roundedRect
        textField.setPlaceholderPadding()
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            textField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)])
    }
    
    private func createRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle("Зареєструватися", for: .normal)
        registrationButton.setTitleColor(.bwtcLightGrey, for: .normal)
        registrationButton.backgroundColor = .bwtcOragge
        registrationButton.tintColor = .bwtcOragge
        registrationButton.layer.cornerRadius = 12
        registrationButton.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
    }
    
    private func createRegistrationLabel() {
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        registrationLabel.text = "Реєстрація"
        registrationLabel.textColor = .bwtcGrey
        registrationLabel.textAlignment = .center
        registrationLabel.numberOfLines = 0
        registrationLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            
            registrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            registrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            registrationLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            
            
            surnameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 40),
            nameTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            
            numberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            
            registrationButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 70),
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            registrationButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            
            
        ])
    }
    
    @objc func registrationButtonAction() {
        
    }
    
}

extension UITextField {
    func setPlaceholderPadding() {
        let placeholderText = self.placeholder ?? ""
        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .font: self.font ?? UIFont.systemFont(ofSize: 17.0),
                .foregroundColor: UIColor.bwtcOragge
            ]
        )
        self.attributedPlaceholder = attributedPlaceholder
    }
}

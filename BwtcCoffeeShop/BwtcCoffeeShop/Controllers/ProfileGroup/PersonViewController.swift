//
//  PersonViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 27.03.2024.
//

import UIKit

// MARK: - Протокол для оновлення таблиці persontableView після виходу користувача з аккаунта
protocol PersonViewControllerDelegate: AnyObject {
    func changeLable()
}

// MARK: - Контроллер вигляду з інформації про зереєстрованого користувача з можливісттю редагування
class PersonViewController: UIViewController {
    
    
    
    let personFirstNameLabel = UILabel()
    let personLastNameLabel = UILabel()
    let personPhoneLabel = UILabel()
    let personEmailLabel = UILabel()
    
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let phoneTextField = UITextField()
    let emailTextField = UITextField()
    
  
    
    let personSingOutButton = UIButton()
    var personViewModel = PersonViewModel()
    var delegate: PersonViewControllerDelegate?
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(emailTextField)
        view.addSubview(personFirstNameLabel)
        view.addSubview(personLastNameLabel)
        view.addSubview(personPhoneLabel)
        view.addSubview(personEmailLabel)
        view.addSubview(personSingOutButton)
        createTextFields()
        createPersonSingOutButton()
        createLabels()
        makeConstraints()
        createNavionItem()
        getPersonData()
   
    }
    

    
    //MARK: - Метод для творення та налаштування NavionItem
    func createNavionItem() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.setupNavBarColor()
        let logoImageItem = "Особисті данні"
        navigationItem.title = logoImageItem
    }
    
    // MARK: - Метод для створення  Labels
    private func createLabels() {
        updateLabels(label: personFirstNameLabel, text: "Ім'я")
        updateLabels(label: personLastNameLabel, text: "Фамілія")
        updateLabels(label: personEmailLabel, text: "Електорнна адреса")
        updateLabels(label: personPhoneLabel, text: "Мобільний телефон")
    }
    
    //MARK: - Метод для налаштування однакових характеристик Labels
    private func updateLabels(label: UILabel, text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    //MARK: - Строверння та налаштування зовнішнього вигляду TextFields
    private func createTextFields() {
        firstNameTextField.updateTextFields(placeholder: "", view: self.view)
        lastNameTextField.updateTextFields(placeholder: "", view: self.view)
        emailTextField.updateTextFields(placeholder: "", view: self.view)
        phoneTextField.updateTextFields(placeholder: "", view: self.view)
        
       
    }
    
    //MARK: - Строверння та налаштування зовнішнього вигляду SingOutButton для виходу з аккаунта
    private func createPersonSingOutButton() {
        personSingOutButton.translatesAutoresizingMaskIntoConstraints = false
        personSingOutButton.customButton(title: "Вийти", view: self.view)
        personSingOutButton.addTarget(self, action: #selector( personSingOutButtonAction), for: .touchUpInside)
    }
    
    //MARK: - Метод для встановлення констрентів для всих об'єктів екрана
    private func  makeConstraints() {
        NSLayoutConstraint.activate([
            personFirstNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            firstNameTextField.topAnchor.constraint(equalTo: personFirstNameLabel.bottomAnchor, constant: 3),
            
            personLastNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.topAnchor.constraint(equalTo: personLastNameLabel.bottomAnchor, constant: 3),
            
            personEmailLabel.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: personEmailLabel.bottomAnchor, constant: 3),
            
            personPhoneLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            phoneTextField.topAnchor.constraint(equalTo: personPhoneLabel.bottomAnchor, constant: 3),
            
            personSingOutButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 50)
        ])
        
    }
    
    //MARK: - Отримання данних зереєстрованого користувача
        private func getPersonData() {
            personViewModel.getPersonData(firstName: firstNameTextField, lastName: lastNameTextField, email: emailTextField, phone: phoneTextField)
        }
    
  

    //MARK: - Метод для виходу з аккаунта при натисненні на кнопку SingOutButton
    @objc func personSingOutButtonAction() {
        personViewModel.personSingOutButtonAction(firstName: firstNameTextField, lastName: lastNameTextField, email: emailTextField, phone: phoneTextField)
        delegate?.changeLable()
        AlertManager.shared.showSingOutAlert(vc: self)
        navigationController?.popViewController(animated: true)
           }
      
    
}



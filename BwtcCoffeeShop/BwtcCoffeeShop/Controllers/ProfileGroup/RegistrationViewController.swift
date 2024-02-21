//
//  RegistrationViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.02.2024.
//

import UIKit

protocol CustomViewDelegate: AnyObject {
    func didTapNewUserButton()
    func didTapUserButton()
}


class RegistrationViewController: UIViewController, CustomViewDelegate {
    
    
    let logoImageView = UIImageView()
    let cancelButton = UIButton()
    let facebookLogin = UIButton()
    let googleLogin = UIButton()
    
   let newUserView = RegistrationCustomView(conteinerData: .init(labelText: "Я новий користувач"))
    
    let userView  = RegistrationCustomView(conteinerData: .init(labelText: "У мене вже є акаунт"))
      

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        newUserView.delegate = self
        userView.delegate = self
        setupView()
    }
    
    private func setupView() {
        view.addSubview(newUserView)
        view.addSubview(logoImageView)
        view.addSubview(userView)
        view.addSubview(cancelButton)
        view.addSubview(facebookLogin)
        view.addSubview(googleLogin)
        createLogoImageView()
        createCancelButton()
        createFacebookLogin()
        createGoogleLogin()
        makeConstraints()
    }

    
    private func createLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "2023-04-23 11.19.26")
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 35
    
    }

    private func createCancelButton() {
        
    }
    
    private func createFacebookLogin() {
        
    }
    
    private func createGoogleLogin() {
        
    }
    
    private func makeConstraints() {
        
        newUserView.translatesAutoresizingMaskIntoConstraints = false
        userView.translatesAutoresizingMaskIntoConstraints = false
     
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            newUserView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            newUserView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            newUserView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            newUserView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userView.topAnchor.constraint(equalTo: newUserView.bottomAnchor, constant: 35),
            userView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            userView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            userView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
        ])
        
    }
    
    
    func didTapNewUserButton() {
            let viewController = PaymentDeliveryViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
    
    func didTapUserButton() {
        let viewController = AdressViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    
}

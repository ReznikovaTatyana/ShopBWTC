//
//  AuthorizationViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.02.2024.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase
import GoogleSignInSwift
import FacebookLogin
import FBSDKLoginKit

protocol AuthorizationViewControllerDelegate {
    
}
    
class AuthorizationViewController: UIViewController {
    
    
    private var googleViewModel = GoogleAuthenticationViewModel()
    private var personTV = PersonTableViewCell()
    weak var alertDelegate: AlertManagerActionDelegate?
    

    
    let logoImageView = UIImageView()
    
    let nameUserTextField = UITextField()
    let passwordUserTextField = UITextField()
    let signInButton = UIButton(type: .custom)
    let registrationButton =  UIButton(type: .custom)
    
    let googleAuthorizationView = UIView()
    let googleLogoImageView = UIImageView()
    let googleAuthorizationButton = UIButton(type: .custom)
    
    let facebookAuthorizationView = UIView()
    let facebookLogoImageView = UIImageView()
    var facebookAuthorizationButton = UIButton(type: .custom)
    
    let forgotPassword = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupView() {
        createTextFields()
        createLogoImageView()
        createCancelButton()
        createSighInButton()
        createFacebookAuthorizationButton()
        createFacebookAuthorizationView()
        createFacebookLogoImageView()
        createGoogleAuthorizationButton()
        createGoogleAuthorizationView()
        createGoogleLogoImageView()
        createRegistrationButton()
        createForgotPassword()
        makeConstraints()
    }
    
    
    private func createTextFields() {
        view.addSubview(nameUserTextField)
        view.addSubview(passwordUserTextField)
        nameUserTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordUserTextField.translatesAutoresizingMaskIntoConstraints = false
        nameUserTextField.placeholder = "Ел.пошта"
        passwordUserTextField.placeholder = "Пароль"
        nameUserTextField.borderStyle = .roundedRect
        passwordUserTextField.borderStyle = .roundedRect
    }
    
    
    private func createLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "2023-04-23 11.19.26")
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 35
    }
    
    private func createSighInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Увійти", for: .normal)
        signInButton.setTitleColor(.bwtcLightGrey, for: .normal)
        signInButton.backgroundColor = .bwtcOragge
        signInButton.tintColor = .bwtcOragge
        signInButton.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            nameUserTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            signInButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
       
        signInButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
    }
    
    private func createRegistrationButton() {
        view.addSubview(registrationButton)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitleColor(.bwtcOragge, for: .normal)
        registrationButton.contentVerticalAlignment = .center
        registrationButton.contentHorizontalAlignment = .left
        registrationButton.backgroundColor = .clear
        let text = "Зареєструватися"
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 15),
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        registrationButton.setAttributedTitle(attributedText, for: .normal)
        registrationButton.addTarget(self, action: #selector(pushToRegistrationVC), for: .touchUpInside)
    }
    
    private func createForgotPassword() {
        view.addSubview(forgotPassword)
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
        forgotPassword.setTitleColor(.bwtcOragge, for: .normal)
        forgotPassword.contentVerticalAlignment = .center
        forgotPassword.contentHorizontalAlignment = .left
        forgotPassword.backgroundColor = .clear
        let text = "Відновити пароль"
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 15),
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        forgotPassword.setAttributedTitle(attributedText, for: .normal)
        forgotPassword.addTarget(self, action: #selector(pushToForgotPasswordVC), for: .touchUpInside)
        
    }
    
    private func createGoogleAuthorizationView() {
        view.addSubview(googleAuthorizationView)
        googleAuthorizationView.addSubview(googleLogoImageView)
        googleAuthorizationView.addSubview(googleAuthorizationButton)
        googleAuthorizationView.translatesAutoresizingMaskIntoConstraints = false
        googleAuthorizationView.layer.borderColor = UIColor.bwtcGrey.cgColor
        googleAuthorizationView.backgroundColor = .white
        googleAuthorizationView.clipsToBounds = true
        googleAuthorizationView.layer.cornerRadius = 10
        googleAuthorizationView.layer.borderWidth = 1.0
        
    }
    
    private func createGoogleAuthorizationButton() {
        googleAuthorizationButton.translatesAutoresizingMaskIntoConstraints = false
        googleAuthorizationButton.backgroundColor = .clear
        googleAuthorizationButton.addTarget(self, action: #selector(didTapGoogleLogin), for: .touchUpInside)
    }
    
    private func createGoogleLogoImageView() {
        googleLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        googleLogoImageView.image = UIImage(named: "google_icon-icons.com_62736")
        googleLogoImageView.contentMode = .scaleAspectFit
    }
    
    
    
    private func createFacebookAuthorizationView() {
        view.addSubview(facebookAuthorizationView)
        facebookAuthorizationView.addSubview(facebookLogoImageView)
        facebookAuthorizationView.addSubview(facebookAuthorizationButton)
        facebookAuthorizationView.translatesAutoresizingMaskIntoConstraints = false
        facebookAuthorizationView.layer.borderColor = UIColor.bwtcGrey.cgColor
        facebookAuthorizationView.backgroundColor = .white
        facebookAuthorizationView.clipsToBounds = true
        facebookAuthorizationView.layer.cornerRadius = 10
        facebookAuthorizationView.layer.borderWidth = 1.0
    }
    
    private func createFacebookLogoImageView() {
        facebookLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        facebookLogoImageView.image = UIImage(named: "2021_Facebook_icon.svg")
        facebookLogoImageView.contentMode = .scaleAspectFit
        
    }
    
    private func createFacebookAuthorizationButton() {
        facebookAuthorizationButton.translatesAutoresizingMaskIntoConstraints = false
        facebookAuthorizationButton.backgroundColor = .clear
        facebookAuthorizationButton.clipsToBounds = true
        facebookAuthorizationButton.layer.cornerRadius = 10
        facebookAuthorizationButton.layer.borderWidth = 1.0
        facebookAuthorizationButton.layer.borderColor = UIColor.bwtcLightGrey.cgColor
        facebookAuthorizationButton.addTarget(self, action: #selector(didTapFacebookLogin), for: .touchUpInside)
    }
    
    
    private func createCancelButton() {
        
    }
    
    
    
    
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            nameUserTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
            nameUserTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameUserTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            nameUserTextField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            
            
            passwordUserTextField.topAnchor.constraint(equalTo: nameUserTextField.bottomAnchor, constant: 20),
            passwordUserTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordUserTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordUserTextField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            
            
            registrationButton.topAnchor.constraint(equalTo: passwordUserTextField.bottomAnchor, constant: 7),
            registrationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            registrationButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.07),
            registrationButton.leadingAnchor.constraint(equalTo: passwordUserTextField.leadingAnchor),
            
            forgotPassword.topAnchor.constraint(equalTo: registrationButton.topAnchor),
            forgotPassword.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            forgotPassword.heightAnchor.constraint(equalTo: registrationButton.heightAnchor),
            forgotPassword.trailingAnchor.constraint(equalTo: passwordUserTextField.trailingAnchor),
            
            
            signInButton.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 10),
            signInButton.trailingAnchor.constraint(equalTo: facebookAuthorizationView.trailingAnchor),
            signInButton.leadingAnchor.constraint(equalTo: googleAuthorizationView.leadingAnchor),
            signInButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            googleAuthorizationView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            googleAuthorizationView.widthAnchor.constraint(equalToConstant: 150),
            googleAuthorizationView.heightAnchor.constraint(equalToConstant: 40),
            googleAuthorizationView.trailingAnchor.constraint(equalTo:view.centerXAnchor, constant: -10),
            
            
            googleLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            googleLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            googleLogoImageView.centerXAnchor.constraint(equalTo: googleAuthorizationView.centerXAnchor),
            googleLogoImageView.centerYAnchor.constraint(equalTo: googleAuthorizationView.centerYAnchor),
            
            googleAuthorizationButton.widthAnchor.constraint(equalTo: googleAuthorizationView.widthAnchor),
            googleAuthorizationButton.heightAnchor.constraint(equalTo: googleAuthorizationView.heightAnchor),
            googleAuthorizationButton.leadingAnchor.constraint(equalTo: googleAuthorizationView.leadingAnchor),
            googleAuthorizationButton.trailingAnchor.constraint(equalTo: googleAuthorizationView.trailingAnchor),
            
            facebookAuthorizationView.topAnchor.constraint(equalTo: googleAuthorizationView.topAnchor),
            facebookAuthorizationView.widthAnchor.constraint(equalTo: googleAuthorizationView.widthAnchor),
            facebookAuthorizationView.heightAnchor.constraint(equalTo: googleAuthorizationView.heightAnchor),
            facebookAuthorizationView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            
            facebookLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            facebookLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            facebookLogoImageView.centerXAnchor.constraint(equalTo: facebookAuthorizationView.centerXAnchor),
            facebookLogoImageView.centerYAnchor.constraint(equalTo: facebookAuthorizationView.centerYAnchor),
            
            facebookAuthorizationButton.widthAnchor.constraint(equalTo: facebookAuthorizationView.widthAnchor),
            facebookAuthorizationButton.heightAnchor.constraint(equalTo: facebookAuthorizationView.heightAnchor),
            facebookAuthorizationButton.leadingAnchor.constraint(equalTo: facebookAuthorizationView.leadingAnchor),
            facebookAuthorizationButton.trailingAnchor.constraint(equalTo: facebookAuthorizationView.trailingAnchor),
            
        ])
        
    }
    
    @objc private func   signUpButtonAction() {
        let loginRequest = LoginUser(email: nameUserTextField.text ?? "", password: passwordUserTextField.text ?? "")
        
        
        
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.shared.showInvalidEmailAlert(vc: self)
            return
        }
        
        if !Validator.isValidPassword(for: loginRequest.password) {
            AlertManager.shared.showInvalidPasswordAlert(vc: self)
            return
        }
       
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.shared.showSignInErrorAlert(on: self, with: error)
                return
            } else {
                AlertManager.shared.showSingInAlert(vc: self)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func pushToRegistrationVC() {
        let viewController = RegistrationViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func pushToForgotPasswordVC() {
        let viewController = ForgotPasswordViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    @objc private func didTapGoogleLogin()   {
        Task {
            do {
               await googleViewModel.signInGoogle { error in
                    if let error = error {
                        print(error)
                    } else {
                        AlertManager.shared.showSingInAlert(vc: self)
                        self.navigationController?.popViewController(animated: true)
                        print("Sign in with Google successful")
                    }
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    @objc private func didTapFacebookLogin() {
        FacebookAuthenticationViewModel.shared.facebookAuthentication(vc: self)

   }
}



//
//  RegistrationViewController.swift
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




    protocol CustomViewDelegate: AnyObject {
        func didTapNewUserButton()
        func didTapUserButton()
    }
    
    
class AuthorizationViewController: UIViewController {
    
        
        private var viewModel = AuthenticationViewModel()
        
        let logoImageView = UIImageView()
        
        let nameUserTextField = UITextField()
        let passwordUserTextField = UITextField()
        let registrationButton =  UIButton(type: .custom)
        
        let googleAuthorizationView = UIView()
        let googleLogoImageView = UIImageView()
        let googleAuthorizationButton = UIButton(type: .custom)
        
        let facebookAuthorizationView = UIView()
        let facebookLogoImageView = UIImageView()
        let facebookAuthorizationButton = FBLoginButton()
        
        let cancelButton =  UIButton()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
           
            setupView()
            facebookAuthorizationButton.delegate = self
            if let token = AccessToken.current,
                    !token.isExpired {
                let token = token.tokenString
                let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields": "email, name"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
                request.start { connection, result, error in
                    print("\(String(describing: result))")
                }
            } else {
                facebookAuthorizationButton.permissions = ["public_profile", "email"]
            
            }
        }
        
        private func setupView() {
            createTextFields()
            createLogoImageView()
            createCancelButton()
            createFacebookAuthorizationButton()
            createFacebookAuthorizationView()
            createFacebookLogoImageView()
            createGoogleAuthorizationButton()
            createGoogleAuthorizationView()
            createGoogleLogoImageView()
            createRegistrationButton()
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
                
                
                registrationButton.topAnchor.constraint(equalTo: passwordUserTextField.bottomAnchor, constant: 15),
                registrationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                registrationButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.07),
                registrationButton.leadingAnchor.constraint(equalTo: passwordUserTextField.leadingAnchor),
                
                googleAuthorizationView.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 30),
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
        
        @objc func pushToRegistrationVC() {
            let viewController = NewUserRegistrationViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        
        
        @objc private func didTapGoogleLogin()   {
            Task {
                do {
                   await viewModel.signInGoogle { error in
                        if let error = error {
                            print(error)
                        } else {
                            // Операція успішно завершена
                            print("Sign in with Google successful")
                        }
                    }
                } catch {
                    print(error)
                }
            }
            
        }
        
    }

extension AuthorizationViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Facebook login error: \(error.localizedDescription)")
            return
        }

        guard let token = AccessToken.current else {
            print("Failed to get Facebook access token")
            return
        }

        let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token.tokenString, version: nil, httpMethod: .get)
        request.start { connection, result, error in
            if let error = error {
                print("Failed to make graph request: \(error.localizedDescription)")
                return
            }

            if let result = result as? [String: Any] {
                print("Facebook login result: \(result)")
                // Додаткова обробка результатів
            }
        }
    }


    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Facebook logout")
    }
}


//extension AuthorizationViewController: LoginButtonDelegate {
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        let token = result?.token?.tokenString
//        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
//                                                 parameters: ["fields": "email, name"],
//                                                 tokenString: token,
//                                                 version: nil,
//                                                 httpMethod: .get)
//        request.start { connection, result, error in
//            print("\(result)")
//        }
//    }
//    
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        print("LogOut")
//    }
//    
//    
//}
//    
//    
    
struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}


final class AuthenticationViewModel: NSObject {
    
    func signInGoogle(completion: @escaping (Error?) -> Void) async {
        guard let topVC = Utilities.shared.topViewController() else {
            completion(URLError(.cannotFindHost))
            return
        }
        
        do {
            let gidSignResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
            
            let user = gidSignResult.user
            
            guard let idToken = user.idToken?.tokenString else {
                throw URLError(.badServerResponse)
            }
            
            let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: user.accessToken.tokenString)
            
            try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
            completion(nil)
        } catch {
            completion(error)
        }
    }
}

    
    
    
    
    final class Utilities {
        static let shared = Utilities()
        private init() {}
        
        
        func topViewController(controller: UIViewController? = nil) -> UIViewController? {
            let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
            
            if let navigationController = controller as? UINavigationController {
                return topViewController(controller: navigationController.visibleViewController)
            }
            if let tabController = controller as? UITabBarController {
                if let selected = tabController.selectedViewController {
                    return topViewController(controller: selected)
                }
            }
            if let presented = controller?.presentedViewController {
                return topViewController(controller: presented)
            }
            return controller
        }
    }
    
    
    
    struct AuthDataResultModel {
        let uid: String
        let email: String?
        let photoUrl: String?
        
        init(user: User) {
            self.uid = user.uid
            self.email = user.email
            self.photoUrl = user.photoURL?.absoluteString
        }
    }
    
    final class AuthenticationManager {
        
        static let shared = AuthenticationManager()
        private init() {}
        
        func getAuthenticaredUser() throws -> AuthDataResultModel {
            guard let user = Auth.auth().currentUser else {
                throw URLError(.badServerResponse)
            }
            return AuthDataResultModel(user: user)
        }
        
        func singOut() throws {
            try Auth.auth().signOut()
        }
        
    }
    
    
    extension AuthenticationManager {
        func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
            let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
            return try await signIn(credential: credential)
        }
        
        func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            return AuthDataResultModel(user: authDataResult.user)
        }
    }
    


//
//  LoginPasswordAuthenticationViewMode.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

//MARK: - Структура данних для реєстрації користувача
struct RegisterUser {
    var firstUserName: String
    var lastUserName: String
    var email: String
    var phone: String
    var password: String
}

//MARK: - Структура данних для входу користувача
struct LoginUser {
    let email: String
    let password: String
}

//MARK: -
class AuthService {
    public static let shared = AuthService()
    private init() {}
    

    //MARK: Метод який реєструє користувача та створює користувача базі данних Firebase
    public func registerUser(with user: RegisterUser, complition: @escaping (Bool, Error?)->Void) {
        
        let firstUserName = user.firstUserName
        let lastUserName = user.lastUserName
        let email = user.email
        let phone = user.phone
        let password = user.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                complition(false, error)
                return
            }
            guard let resultUser = result?.user else {
                complition(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData(["firstUserName" : firstUserName,
                          "lastUserName": lastUserName,
                          "email": email,
                          "phone": phone]) { error in
                    if let error = error {
                        complition(false, error)
                        return
                    }
                    complition(true, nil)
                }
        }
        
    }
    
//MARK: Метод для входу користувача після реєстрації
    public func signIn(with user: LoginUser, completion: @escaping(Error?)-> Void) {
        Auth.auth().signIn(withEmail: user.email , password: user.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else if let result = result {
                completion(result as? Error)
            }
        }
        
    }
    
//MARK: Метод для виходу користувача
    public func singOut(completion: @escaping (Error?) -> Void) {
        
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            completion(signOutError)
        }
//        do {
//            try Auth.auth().signOut()
//            
//        } catch let error {
//            completion(error)
//        }
        
    }
    
//MARK: Метод для зміни пароля користувача
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
//MARK: Метод для отримання данних зареєстрованих користувачів з бази данних Firebase
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                }
               else if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let firstName = snapshotData["firstUserName"] as? String,
                   let lastName = snapshotData["lastUserName"] as? String,
                   let phone = snapshotData["phone"] as? String,
                   let email = snapshotData["email"] as? String {
                    let user = User(firstName: firstName, lastName: lastName, phone: phone, email: email, userUID: userUID)
                   completion(user, nil)
                        }
                }
            }
    }


//MARK: - Клас для встановлення обмежень вводних данних при реєстрації та авторизації користувача
class Validator {
    
    //MARK: Метод для встановлення обмежень для електронної пошти користувача
    static func isValidEmail(for email: String) -> Bool {
        let email = email
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: Метод для встановлення обмежень для імені користувача
    static func isValidUserName(for userName: String) -> Bool {
        let userName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        let userNameRegEx = "\\w{4,24}"
        let userNamePred = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        return userNamePred.evaluate(with: userName)
    }
    
    //MARK: Метод для встановлення обмежень для паролю користувача
    static func  isValidPassword(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
        
    }
    
}

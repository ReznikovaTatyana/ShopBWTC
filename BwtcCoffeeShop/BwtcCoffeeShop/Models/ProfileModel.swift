//
//  ProfileModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 15.02.2024.
//

import Foundation
import UIKit

struct ProfileModel {
    var image: String
    var label: String
}

protocol ProfileModelProtocol {
    var info: [ProfileModel] { get }
  // var person: [ProfileModel] { get }
}

class ProfileViewModel: ProfileModelProtocol {
 
    var info: [ProfileModel] {
        return [
        ProfileModel(image: "list.bullet.clipboard.fill", label: "Мої замовлення"),
        ProfileModel(image: "car", label: "Доставка та оплата"),
        ProfileModel(image: "plus.app", label: "Співпраця"),
        ProfileModel(image: "globe.central.south.asia.fill", label: "Як нас знайти"),
        ]
    }
    
    
}



class PersonViewModel {
    
    
    var currentUser: User?

    weak var googleViewModel: GoogleAuthenticationViewModel?
    var person: [ProfileModel] {
        return [ProfileModel(image: "person.circle.fill", label: "Увійти")]
    }
    
    
    public func fetchUserData(table: UITableView) {
        DispatchQueue.main.async {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else {return}
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
            } else if let user = user {
                self.currentUser = user
                table.reloadData()
                }
            }
        }
        
    }
    
   
    
    
    public func getPersonData(firstName: UITextField, lastName: UITextField, email:UITextField, phone: UITextField) {
        DispatchQueue.main.async {
            AuthService.shared.fetchUser { [weak self] user, error in
                guard let self = self else {return}
                if let error = error {
                    print(error)
                } else if let user = user {
                    self.currentUser = user
                    firstName.text = self.currentUser?.firstName
                    email.text = self.currentUser?.email
                    lastName.text = self.currentUser?.lastName
                    phone.text = self.currentUser?.phone
                   
                }
                
            }
        }
    }
    
  
    
    
    func personSingOutButtonAction(firstName: UITextField, lastName: UITextField, email:UITextField, phone: UITextField) {
        AuthService.shared.singOut { error in
                    if let error = error {
                        print(error)
                    } else {
                        print("Sign in with Google successful")
                        self.currentUser = nil
                        firstName.text = ""
                        email.text = ""
                        lastName.text = ""
                        phone.text = ""
                    }
                }

           }
      
    
    public func singOutUser() {
        AuthService.shared.singOut {  error in
            if let error = error {
                print(error)
            } else {
                print("Sign in with Google successful")
            }
            
        }
    }
    
}



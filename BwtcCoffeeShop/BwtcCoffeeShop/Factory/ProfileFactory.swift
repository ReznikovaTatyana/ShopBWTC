//
//  ProfileFactory.swift
//  BwtcCoffeeShop
//
//  Created by mac on 15.02.2024.
//

import Foundation
import UIKit
class ProfileViewControllerFactory {
    static func createViewController(for info: ProfileModel) -> UIViewController {
        switch info.label {
        case "Доставка та оплата":
            return PaymentDeliveryViewController()
        case "Мої замовлення":
            return PaymentDeliveryViewController()
        case "Співпраця":
            return PaymentDeliveryViewController()
        case "Як нас знайти":
            return AdressViewController()
        default:
            fatalError("Unsupported category: \(info.label)")
        }
    }
    
    
}


class PersonViewControllerFactory {
    static func personViewController(person: ProfileModel) -> UIViewController {
        if person.label == "Увійти" {
            return  AuthorizationViewController()
        } else {
            return  PersonViewController()
        }
            fatalError("Unsupported category: \(person.label)")
        
     }
}


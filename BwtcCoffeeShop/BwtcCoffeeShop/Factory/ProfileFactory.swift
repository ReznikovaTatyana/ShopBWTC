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
                 
        case "Увійти":
            return AuthorizationViewController()
        case "Мої замовлення":
            return PaymentDeliveryViewController()
        case "Зміна профіля":
            return PaymentDeliveryViewController()
        case "Співпраця":
            return PaymentDeliveryViewController()
        case "Як нас знайти":
            return PaymentDeliveryViewController()
        default:
            fatalError("Unsupported category: \(info.label)")
        }
    }
}



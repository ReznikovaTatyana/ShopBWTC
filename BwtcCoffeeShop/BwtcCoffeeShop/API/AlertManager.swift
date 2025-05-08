//
//  AlertManager.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.03.2024.
//

import Foundation
import UIKit


protocol AlertManagerActionDelegate: AnyObject {
    func didTapOKButton()
}

class AlertManager {
    
    public static let shared = AlertManager()
    private init() {}
    
    private func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            vc.present(alert, animated: true)
            
        }
    }
}


// MARK: - Невірно вказані данні
extension AlertManager {
    
    public func showInvalidEmailAlert(vc: UIViewController) {
        showBasicAlert(on: vc, title: "Недійсна електронна пошта", message: "Будь ласка, введіть дійсну електронну адресу")
    }
    
    public func showInvalidPasswordAlert(vc: UIViewController) {
        showBasicAlert(on: vc, title: "Невірний пароль", message: "Введіть дійсний пароль.")
    }
    
    public func showInvalidUsernameAlert(vc: UIViewController) {
        showBasicAlert(on: vc, title: "Невірний пароль", message: "Введіть дійсний пароль.")
    }
}

// MARK: - Невідома помилка
extension AlertManager {
    public func showRegistrationErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Невідома помилка реєстрації", message: nil)
    }
    
    public func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Невідома помилка реєстрації", message: "\(error.localizedDescription)")
    }
}

// MARK: - Помилка входу
extension AlertManager {
    
    public  func showSignInErrorAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, title: "Невідома помилка входу", message: nil)
    }
    
    public func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        showBasicAlert(on: vc, title: "Помилка входу", message: "\(error.localizedDescription)")
    }
}

extension AlertManager {
    public func showSingInAlert(vc: UIViewController) {
        showBasicAlert(on: vc, title: "Ви успішно ввійшли", message: nil)
    }
}


// MARK: -
extension AlertManager {
    public func showSingOutAlert(vc: UIViewController) {
        showBasicAlert(on: vc, title: "Ви успішно вийшли", message: nil)
    }
}

// MARK: - Забули пароль
extension AlertManager {
    
    public func showPasswordResetSent(vc: UIViewController) {
        showBasicAlert(on: vc, title: "Скидання пароля надіслано", message: nil)
    }
    
    public func showErrorSendingPasswordReset(vc: UIViewController, error: Error) {
        showBasicAlert(on: vc, title: "Помилка надсилання скидання пароля", message: "\(error.localizedDescription)")
    }
}

// MARK: - Отримання помилок користувача
extension AlertManager {
    public func showFetchingUserError(vc: UIViewController, error: Error) {
        showBasicAlert(on: vc, title: "Помилка отримання користувача", message: "\(error.localizedDescription)")
    }
    
    public func showUnknownFetchingUserError(vc: UIViewController) {
        showBasicAlert(on: vc, title: "Невідома помилка отримання користувача", message: nil)
    }
}

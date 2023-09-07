//
//  BasketUserDefaults.swift
//  BwtcCoffeeShop
//
//  Created by mac on 19.07.2023.
//

import Foundation

final class BasketUserDefaults {
    private enum SettingsKey: String {
        case basketModel
    }
    
    static var basketModel: BasketModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKey.basketModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? BasketModel else {return nil}
            return decodedModel
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.basketModel.rawValue
            if let basketModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: basketModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
                
            }
        }
    }
}


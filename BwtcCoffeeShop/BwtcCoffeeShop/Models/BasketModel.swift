//
//  BasketModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 02.06.2023.
//

import Foundation
import UIKit

class BasketModel: Codable {
    var basketImageName: String
    var basketName: String
    var basketGrind: String
    var basketPrice: Int
    var stepper: Int
    var basketCoast: Int
    var basketSalePrice: Int
    var mass: Int
    var identifaer: Int
    var countDrip: Int
    var countPackDrip: Int
    var coastText = ""
    var coastSaleText = ""
   
    
    init(basketImageName: String, basketName: String, basketGrind: String,basketPrice: Int,stepper: Int, basketCoast: Int, basketSalePrice: Int, identifaer: Int, countDrip: Int, countPackDrip: Int, mass: Int) {
        self.basketImageName = basketImageName
        self.basketName = basketName
        self.basketGrind = basketGrind
        self.basketPrice = basketPrice
        self.stepper = stepper
        self.basketCoast = basketCoast
        self.basketSalePrice = basketSalePrice
        self.identifaer = identifaer
        self.countDrip = countDrip
        self.countPackDrip = countPackDrip
        self.mass = mass
       
    } 
}

class BasketViewModel {
    static let shared = BasketViewModel()
    var positions: [BasketModel] = BasketModel.loadBasketModel() {
        didSet {
            BasketModel.save(positions)
        }
    }
    private init() {}
    
    func addPosition(position: BasketModel) {
        if !isContain(model: position) {
       self.positions.append(position)
        }
//    }
    }
   
    
    func calculateSaleTotalCost() -> Int {
        for position in positions {
            let coast = position.basketPrice * position.stepper
            let saleCoast = position.basketSalePrice * position.stepper
            switch position.identifaer {
            case 1: if positions.reduce(0, { $0 + $1.mass * $1.stepper}) >= 3000 {
                position.basketCoast = saleCoast
                position.coastSaleText = String(saleCoast) + "грн"
                } else {
                    position.basketCoast = coast
                    position.coastSaleText = ""
                }
            case 2: if positions.reduce(0, { $0 + $1.countDrip * $1.stepper}) >= 50 {
                position.basketCoast = saleCoast
                position.coastSaleText = String(saleCoast) + "грн"
            } else {
                position.basketCoast = coast
                position.coastSaleText = ""
            }
            case 3: if positions.reduce(0, { $0 + $1.countPackDrip * $1.stepper}) >= 3 {
                position.basketCoast = saleCoast
                position.coastSaleText = String(saleCoast) + "грн"
            } else {
                position.basketCoast = coast
                position.coastSaleText = ""
            }
            default: break
            }
            
            }
        return  positions.reduce(0) { $0 + $1.basketCoast }
    }
    
    

    
    
func isContain(model: BasketModel) -> Bool {
    for item in positions {
        if item.basketGrind.count > 2 {
            if item.basketGrind == model.basketGrind && item.basketName == model.basketName, item.mass == model.mass {
            return true
        }
        } else {
            if item.basketName == model.basketName {
                return true
            }
        }
    }
    return false
}
    
    func removePosition(at index: Int) {
        positions.remove(at: index)
    }
    
}
    
extension  BasketModel {
    static let key = "BasketModelKey"
    static func save(_  basketModel: [BasketModel]) {
        let data = try? JSONEncoder().encode(basketModel)
        UserDefaults.standard.set(data, forKey: BasketModel.key)
    }
    
    static func loadBasketModel() -> [BasketModel] {
        var returnBasketModel: [BasketModel] = []
        if let data = UserDefaults.standard.data(forKey: BasketModel.key),
        let basketModel = try? JSONDecoder().decode([BasketModel].self, from: data) {
            returnBasketModel = basketModel
        }
        return returnBasketModel
    }
}
    




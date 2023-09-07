//
//  GrindModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 06.05.2023.
//

import Foundation
import UIKit

struct TipeGrind {
    var grind: String
}

class ModelGrind {
    var tipeGrind: [TipeGrind] = {
        var noGrind = TipeGrind(grind: "У зерні")
        var tyrka = TipeGrind(grind: "Турка")
        let epresso = TipeGrind(grind: "Espresso")
        let mokka = TipeGrind(grind: "Гейзер")
        let v60 = TipeGrind(grind: "V60")
        let filter = TipeGrind(grind: "Фільтер")
        let frenchPress = TipeGrind(grind: "Френч пресс")
        return [noGrind, tyrka, epresso, mokka, v60, filter, frenchPress]
    }()
}





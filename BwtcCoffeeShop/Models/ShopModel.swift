//
//  ShopModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import Foundation
import UIKit
struct Shop {
    var name: String?
    var imageName: String?
    var price: Int?
    var optPrice: Int?
    var wt: Int?
    var mass: Int?
    var text: String?
}

struct SectionCoffee {
    let sectionName: String
    var coffee: [Shop]
}

class ContentCoffeeShopCell {
    var itemShopArray: [Shop] = {
    var blanckShop = Shop()
        blanckShop.name = "Ethiopia Guji natural 250гр"
        blanckShop.imageName = "bwtc mockup-8"
        blanckShop.price = 300
        blanckShop.optPrice = 250
        blanckShop.wt = 250
        blanckShop.mass = 250
        blanckShop.text = " Ethiopia Guji Shonora Країна: Ethiopia Регіон: Oromia Різновид: Heirloom Метод обробки: Natural Висота: 1900 - 2300 м.н.р.м Про Shonora coffee Це зерно походить із зони Guji південного регіону Oromia, що вважаться батьківщиною кави. Він має ідеальні умови для вирощування арабіки: значну висотність (понад 1500 м.); багаті, добре дреновані (в основному вулканічні) ґрунти, що майже не потребують додаткових добрив; високогірний тропічний клімат із 1500–2500 мм опадів протягом дев’ятимісячного періоду та оптимальними температурами від 15 до 24°C"
    var blanckShop2 = Shop()
        blanckShop2.name = "Colombia Medellin 250гр"
        blanckShop2.imageName = "bwtc mockup-8"
        blanckShop2.price = 400
        blanckShop2.optPrice = 250
        blanckShop2.wt = 250
        blanckShop2.mass = 250
        
    var blanckShop3 = Shop()
        blanckShop3.name = "Ethiopia Limu 250гр"
        blanckShop3.imageName = "Ethiopia Limu"
        blanckShop3.price = 500
        blanckShop3.optPrice = 250
        blanckShop3.wt = 250
        blanckShop3.mass = 250
    var blanckShop4 = Shop()
        blanckShop4.name = "Kenya Kijani Kiboko 250гр"
        blanckShop4.imageName = "Kenya Kijani Kiboko"
        blanckShop4.price = 273
        blanckShop4.optPrice = 250
        blanckShop4.wt = 250
        blanckShop4.mass = 250
    var blanckShop5 = Shop()
        blanckShop5.name = "Peru Amazonas 250гр"
        blanckShop5.imageName = "Peru Amazonas"
        blanckShop5.price = 273
        blanckShop5.optPrice = 250
        blanckShop5.wt = 250
    var blanckShop6 = Shop()
        blanckShop6.name = "Peru Cajamarca 250гр"
        blanckShop6.imageName = "Peru Cajamarca"
        blanckShop6.price = 260
        blanckShop6.optPrice = 250
        blanckShop6.wt = 250
    return [blanckShop, blanckShop2, blanckShop3, blanckShop4, blanckShop5, blanckShop6]
}()
    var bigPackArray: [Shop] = {
        var pack1 = Shop()
        pack1.name = "Ethiopia Guji natural 1kg"
        pack1.imageName = "ethiopia guji espresso"
        pack1.price = 350
        pack1.optPrice = 250
        pack1.wt = 1000
        var pack2 = Shop()
        pack2.name = "Colombia Medellin  1kg"
        pack2.imageName = "colombia medellin"
        pack2.price = 350
        pack2.optPrice = 250
        pack2.wt = 1000
        var pack3 = Shop()
        pack3.name = "Ethiopia Limu 1kg"
        pack3.imageName = "mockup 1kg-2"
        pack3.price = 350
        pack3.optPrice = 250
        pack3.wt = 1000
        
        
        return [pack1, pack2, pack3]
    }()
}


class DrippCell {
    var drippArray: [Shop] = {
    var blanckShop = Shop()
        blanckShop.name = "Dripp colombia"
        blanckShop.imageName = "bwtc drip mockup-2"
        blanckShop.price = 273
    var blanckShop2 = Shop()
        blanckShop2.name = "Dripp"
        blanckShop2.imageName = "bwtc drip mockup-3"
        blanckShop2.price = 273
    var blanckShop3 = Shop()
        blanckShop3.name = "Dripp"
        blanckShop3.imageName = "bwtc drip mockup"
        blanckShop3.price = 273
    var blanckShop4 = Shop()
        blanckShop4.name = "Dripp"
        blanckShop4.imageName = "colombia"
        blanckShop4.price = 273
    var blanckShop5 = Shop()
        blanckShop5.name = "Dripp honduras"
        blanckShop5.imageName = "honduras"
        blanckShop5.price = 273
    var blanckShop6 = Shop()
        blanckShop6.name = "Dripp colombia 2"
        blanckShop6.imageName = "colombia 2"
        blanckShop6.price = 260
//    var blanckShop7 = Shop()
//        blanckShop7.name = "Guatemala La Bella 250гр"
//        blanckShop7.imageName = ""
//        blanckShop7.price = 260
//    var blanckShop8 = Shop()
//        blanckShop8.name = "EL Salvador Las Marias washed 250гр"
//        blanckShop8.imageName = ""
//        blanckShop8.price = "260$"
//    var blanckShop9 = Shop()
//        blanckShop9.name = "Kenya Rutuma Ruthagati 250гр"
//        blanckShop9.imageName = ""
//        blanckShop9.price = "260$"
    return [blanckShop, blanckShop2, blanckShop3, blanckShop4, blanckShop5, blanckShop6]
}()
    
        var teaArray: [Shop] = {
            var tea1 = Shop()
            tea1.name = "Matcha"
            tea1.imageName = "2022-10-04 18.27.04"
            tea1.price = 550
        return [tea1]
    }()
    
    var accessoriesArray: [Shop] = {
        var accessories1 = Shop()
        accessories1.name = "Dotyc"
        accessories1.imageName = "IMG_1570"
        accessories1.price = 1600
        var accessories2 = Shop()
        accessories2.name = "Timemore C3"
        accessories2.imageName = "kavomolka-nano-66774813160123"
        accessories2.price = 3300
        return [accessories1, accessories2]
    }()
    
    
}

class PopularProducts {
    var popularProductsArray: [Shop] = {
     var blanckProducts1 = Shop()
        blanckProducts1.name = "Dripp"
        blanckProducts1.imageName = "colombia 2"
        blanckProducts1.price = 280
    var blanckProducts2 = Shop()
        blanckProducts2.name = "Dripp colombia"
        blanckProducts2.imageName = "colombia 2"
        blanckProducts2.price = 280
    var blanckProducts3 = Shop()
        blanckProducts3.name = "Dripp"
        blanckProducts3.imageName = "colombia 2"
        blanckProducts3.price = 280
    var blanckProducts4 = Shop()
        blanckProducts4.name = "Dripp Ethiopia"
        blanckProducts4.imageName = "bwtc mockup-8"
        blanckProducts4.price = 280
        blanckProducts4.text = " Ethiopia Guji Shonora Країна: Ethiopia Регіон: Oromia Різновид: Heirloom Метод обробки: Natural Висота: 1900 - 2300 м.н.р.м Про Shonora coffee Це зерно походить із зони Guji південного регіону Oromia, що вважаться батьківщиною кави. Він має ідеальні умови для вирощування арабіки: значну висотність (понад 1500 м.); багаті, добре дреновані (в основному вулканічні) ґрунти, що майже не потребують додаткових добрив; високогірний тропічний клімат із 1500–2500 мм опадів протягом дев’ятимісячного періоду та оптимальними температурами від 15 до 24°C"
    var blanckProducts5 = Shop()
        blanckProducts5.name = "Dripp"
        blanckProducts5.imageName = "colombia 2"
        blanckProducts5.price = 280
        var blanckProducts6 = Shop()
        blanckProducts6.name = "Dripp"
        blanckProducts6.imageName = "bwtc mockup-8"
        blanckProducts6.price = 280
//        var blanckProducts7 = Shop()
//            blanckProducts7.name = "Dripp"
//            blanckProducts7.imageName = "colombia 2"
//            blanckProducts7.price = 280
        
        return [blanckProducts1, blanckProducts2, blanckProducts3, blanckProducts4,blanckProducts5, blanckProducts6]
    }()
}




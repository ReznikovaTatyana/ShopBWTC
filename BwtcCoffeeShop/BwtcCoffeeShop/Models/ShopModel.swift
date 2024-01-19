//
//  ShopModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import Foundation
import UIKit


struct Goods {
    var name: String?
    var imageName: String?
    var price: Int?
    var optPrice: Int?
    var countDrip: Int?
    var mass: Int?
    var text: String?
    var identifaer: Int?
}

protocol GoodsForShopProtocol {
    var goods: [Goods] {get}
}

struct SectionCoffee {
    let sectionName: String
    var coffee: [Goods]
}

class CoffeeSmallPacks: GoodsForShopProtocol {
    
//    var goods: [Goods] = []
//
//       func loadGoodsFromFirebase() {
//           // Отримання посилань на документи товарів у колекції "goods"
//           let db = Firestore.firestore()
//           let goodsCollection = db.collection("goods")
//
//           goodsCollection.getDocuments { (querySnapshot, error) in
//               if let error = error {
//                   print("Помилка отримання даних з Firebase: \(error.localizedDescription)")
//                   return
//               }
//
//               // Обробка отриманих документів та створення об'єктів Goods
//               for document in querySnapshot!.documents {
//                   let data = document.data()
//                   let name = data["name"] as? String ?? ""
//                   let imageName = data["imageName"] as? String ?? ""
//                   let price = data["price"] as? Int ?? 0
//                   let optPrice = data["optPrice"] as? Int ?? 0
//                   let countDrip = data["countDrip"] as? Int ?? 0
//                   let mass = data["mass"] as? Int ?? 0
//                   let text = data["text"] as? String ?? ""
//                   let identifier = data["identifier"] as? Int ?? 0
//
//                   let goodsObject = Goods(name: name, imageName: imageName, price: price, optPrice: optPrice, countDrip: countDrip, mass: mass, text: text, identifier: identifier)
//
//                   // Додавання об'єкта Goods до масиву
//                   self.goods.append(goodsObject)
//               }
//
//               // Оновлення інтерфейсу або виклик інших функцій, якщо потрібно
//           }
//       }
//
    var goods: [Goods] {
        return [ Goods(name: "Ethiopia Guji natural 250гр", imageName: "bwtc mockup-8", price:  300, optPrice: 100, countDrip: 0, mass: 250, text: " Ethiopia Guji Shonora Країна: Ethiopia Регіон: Oromia Різновид: Heirloom Метод обробки: Natural Висота: 1900 - 2300 м.н.р.м Про Shonora coffee Це зерно походить із зони Guji південного регіону Oromia, що вважаться батьківщиною кави. Він має ідеальні умови для вирощування арабіки: значну висотність (понад 1500 м.); багаті, добре дреновані (в основному вулканічні) ґрунти, що майже не потребують додаткових добрив; високогірний тропічний клімат із 1500–2500 мм опадів протягом дев’ятимісячного періоду та оптимальними температурами від 15 до 24°C", identifaer: 1),
            Goods(name: "Colombia Medellin 250гр", imageName: "bwtc mockup-8", price: 400, optPrice: 100, countDrip: 0, mass: 250, text: "", identifaer: 1),
            Goods(name: "Ethiopia Limu 250гр", imageName: "Ethiopia Limu", price: 500, optPrice: 100, countDrip: 0, mass: 250, text: "", identifaer: 1),
                 Goods(name: "Kenya Kijani Kiboko 250гр", imageName: "Kenya Kijani Kiboko", price: 273, optPrice: 100, countDrip: 0, mass: 250, text: "", identifaer: 1),
                 Goods(name: "Peru Amazonas 250гр", imageName: "Peru Amazonas", price: 273, optPrice: 100, countDrip: 0, mass: 250, text: "", identifaer: 1),
                 Goods(name: "Peru Cajamarca 250гр", imageName: "Peru Cajamarca", price: 260, optPrice: 100, countDrip: 0, mass: 250, text: "", identifaer: 1)
        ]
    }
    
    var bigPackArray: [Goods] = {
        var pack1 = Goods()
        pack1.identifaer = 1
        pack1.name = "Ethiopia Guji natural 1kg"
        pack1.imageName = "ethiopia guji espresso"
        pack1.price = 500
        pack1.optPrice = 350
        pack1.countDrip = 0
        pack1.mass = 1000
        var pack2 = Goods()
        pack2.name = "Colombia Medellin  1kg"
        pack2.imageName = "colombia medellin"
        pack2.price = 500
        pack2.optPrice = 350
        pack2.identifaer = 1
        pack2.countDrip = 0
        pack2.mass = 1000
        var pack3 = Goods()
        pack3.name = "Ethiopia Limu 1kg"
        pack3.imageName = "mockup 1kg-2"
        pack3.price = 500
        pack3.optPrice = 350
        pack3.identifaer = 1
        pack3.countDrip = 0
        pack3.mass = 1000
        return [pack1, pack2, pack3]
    }()
}


class DrippCell {
    var drippArray: [Goods] = {
    var blanckShop = Goods()
        blanckShop.identifaer = 2
        blanckShop.name = "Dripp colombia"
        blanckShop.imageName = "bwtc drip mockup-2"
        blanckShop.price = 30
        blanckShop.optPrice = 20
        blanckShop.identifaer = 2
        blanckShop.countDrip = 1
        blanckShop.mass = 0
    var blanckShop2 = Goods()
        blanckShop2.name = "Dripp"
        blanckShop2.imageName = "bwtc drip mockup-3"
        blanckShop2.price = 30
        blanckShop2.optPrice = 20
        blanckShop2.identifaer = 2
        blanckShop2.countDrip = 1
        blanckShop2.mass = 0
    var blanckShop3 = Goods()
        blanckShop3.name = "Dripp"
        blanckShop3.imageName = "bwtc drip mockup"
        blanckShop3.price = 30
        blanckShop3.optPrice = 20
        blanckShop3.identifaer = 2
        blanckShop3.countDrip = 1
        blanckShop3.mass = 0
    var blanckShop4 = Goods()
        blanckShop4.name = "Dripp"
        blanckShop4.imageName = "colombia"
        blanckShop4.price = 30
        blanckShop4.optPrice = 20
        blanckShop4.identifaer = 2
        blanckShop4.countDrip = 1
        blanckShop4.mass = 0
    var blanckShop5 = Goods()
        blanckShop5.name = "Dripp honduras"
        blanckShop5.imageName = "honduras"
        blanckShop5.price = 30
        blanckShop5.optPrice = 20
        blanckShop5.identifaer = 2
        blanckShop5.countDrip = 1
        blanckShop5.mass = 0
    var blanckShop6 = Goods()
        blanckShop6.name = "Dripp colombia 2"
        blanckShop6.imageName = "colombia 2"
        blanckShop6.price = 30
        blanckShop6.optPrice = 20
        blanckShop6.identifaer = 2
        blanckShop6.countDrip = 1
        blanckShop6.mass = 0
    return [blanckShop, blanckShop2, blanckShop3, blanckShop4, blanckShop5, blanckShop6]
}()
    
        var teaArray: [Goods] = {
            var tea1 = Goods()
            tea1.name = "Matcha"
            tea1.imageName = "2022-10-04 18.27.04"
            tea1.price = 550
        return [tea1]
    }()
    
    var accessoriesArray: [Goods] = {
        var accessories1 = Goods()
        accessories1.name = "Dotyc"
        accessories1.imageName = "IMG_1570"
        accessories1.price = 1600
        var accessories2 = Goods()
        accessories2.name = "Timemore C3"
        accessories2.imageName = "kavomolka-nano-66774813160123"
        accessories2.price = 3300
        return [accessories1, accessories2]
    }()
    
    
}



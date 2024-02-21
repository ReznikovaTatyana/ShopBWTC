//
//  ShopModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase
import FirebaseDatabase
import FirebaseFirestore


struct Goods {
    var ID: String?
    var name: String?
    var imageName: String?
    var price: Int?
    var optPrice: Int?
    var countDrip: Int?
    var countPackDrip: Int?
    var mass: Int?
    var text: String?
    var identifaer: Int?
}

protocol GoodsForShopProtocol {
    var goods: [Goods] { get }
}

struct SectionCoffee {
    let sectionName: String
    var coffee: [Goods]
}


class ShopViewModel {
  
    var packCoffeeArray = [Goods]()
    var bigPackArray = [Goods]()
    var drippArray = [Goods]()
    
    //Оновлення даних в goods з Firebase
    func updateGoodsFromFirebase(completion: @escaping () -> Void)  {
        APIManager.shared.apiCoffeePack { [weak self] fetchedGoods in
            DispatchQueue.main.async {
                self?.packCoffeeArray = fetchedGoods
                completion()
            }
        }
    }
    
    
    func updateGoodsFromFirebaseBigPack(completion: @escaping () -> Void)  {
        APIManager.shared.apiCoffeBigPack { [weak self] fetchedGoods in
            // Оновлення властивості goods з отриманими даними
            DispatchQueue.main.async {
                self?.bigPackArray = fetchedGoods
                completion()
            }
            
        }
    }
    
    
    func updateGoodsFromFirebaseDrip(completion: @escaping () -> Void)  {
        APIManager.shared.apiDrip { [weak self] fetchedGoodsDrip in
            // Оновлення властивості goods з отриманими даними
            DispatchQueue.main.async {
                self?.drippArray = fetchedGoodsDrip
                completion()
            }
            
        }
    }
    
    
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



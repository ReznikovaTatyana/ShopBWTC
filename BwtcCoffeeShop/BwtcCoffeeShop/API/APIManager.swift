 //
//  APIManager.swift
//  BwtcCoffeeShop
//
//  Created by mac on 22.01.2024.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class APIManager {
    static let shared = APIManager()
    private let database = Database.database().reference()
    
    private func fetchItemsFromReference(_ itemsReference: DatabaseReference, completion: @escaping ([Goods]) -> Void) {
           itemsReference.observeSingleEvent(of: .value) { snapshot in
               guard snapshot.exists() else {
                   print("Snapshot does not exist")
                   return
               }
               
               var goods: [Goods] = []

               for childSnapshot in snapshot.children {
                   guard let snapshot = childSnapshot as? DataSnapshot,
                       let itemData = snapshot.value as? [String: Any],
                       let name = itemData["name"] as? String,
                       let imageName = itemData["imageName"] as? String,
                       let price = itemData["price"] as? Int,
                       let text = itemData["text"] as? String,
                       let mass = itemData["mass"] as? Int,
                       let identifaer = itemData["identifaer"] as? Int,
                       let countDrip = itemData["countDrip"] as? Int,
                       let countPackDrip = itemData["countPackDrip"] as? Int,
                       let optPrice = itemData["optPrice"] as? Int else {
                           print("Error: Unable to parse item data")
                           continue
                   }

                   var item = Goods()
                   item.name = name
                   item.imageName = imageName
                   item.price = price
                   item.optPrice = optPrice
                   item.countDrip = countDrip
                   item.mass = mass
                   item.text = text
                   item.identifaer = identifaer
                   item.countPackDrip = countPackDrip
                   item.ID = snapshot.key
                   goods.append(item)
               }

               completion(goods)
           }
       }

       func apiCoffeePack(completion: @escaping ([Goods]) -> Void) {
           fetchItemsFromReference(database.child("goods"), completion: completion)
       }

       func apiCoffeBigPack(completion: @escaping ([Goods]) -> Void) {
           fetchItemsFromReference(database.child("goods2"), completion: completion)
       }

       func apiDrip(completion: @escaping ([Goods]) -> Void) {
           fetchItemsFromReference(database.child("goods3"), completion: completion)
       }

       func apiPopularPack(completion: @escaping ([Goods]) -> Void) {
           fetchItemsFromReference(database.child("goods4"), completion: completion)
       }
   }


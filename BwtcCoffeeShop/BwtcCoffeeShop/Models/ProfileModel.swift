//
//  ProfileModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 15.02.2024.
//

import Foundation

struct ProfileModel {
    var image: String
    var label: String
}

protocol ProfileModelProtocol {
    var info: [ProfileModel] { get }
}

class ProfileViewModel: ProfileModelProtocol {
 
    
    var info: [ProfileModel] {
        return [
        ProfileModel(image: "person.circle.fill", label: "Увійти"),
        ProfileModel(image: "list.bullet.clipboard.fill", label: "Мої замовлення"),
        ProfileModel(image: "person.2.badge.gearshape.fill", label: "Зміна профіля"),
        ProfileModel(image: "car", label: "Доставка та оплата"),
        ProfileModel(image: "plus.app", label: "Співпраця"),
        ProfileModel(image: "globe.central.south.asia.fill", label: "Як нас знайти"),
        ]
    }
}

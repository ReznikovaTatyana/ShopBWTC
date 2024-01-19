//
//  CatalogModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 31.08.2023.
//

import Foundation

struct Category {
    var name: String
    var imageName: String
}

protocol CategoriesForCatalogProtocol {
    var categories: [Category] { get }
}

class CategoriesForCatalog:  CategoriesForCatalogProtocol {
    var categories: [Category] {
        return [
        Category(name: "Coffee", imageName: "IMG_7370"),
        Category(name: "Dripp", imageName: "IMG_7364"),
        Category(name: "Tea", imageName: "IMG_7372"),
        Category(name: "Accessories", imageName: "IMG_7366")
        ]
    }
}

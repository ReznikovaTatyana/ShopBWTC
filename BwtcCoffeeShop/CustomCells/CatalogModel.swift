//
//  CatalogModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 31.08.2023.
//

import Foundation

struct Category {
    var name: String?
    var imageName: String?
}

class CategoryCollectionViewCell {
    var contentCategoryCell: [Category] = {
        var blankCategory1 = Category()
        blankCategory1.imageName = "IMG_7370"
        blankCategory1.name = "Coffee"
        var blankCategory2 = Category()
        blankCategory2.imageName = "IMG_7364"
        blankCategory2.name = "Dripp"
        var blankCategory3 = Category()
        blankCategory3.imageName = "IMG_7372"
        blankCategory3.name = "Tea"
        var blankCategory4 = Category()
        blankCategory4.imageName = "IMG_7366"
        blankCategory4.name = "Accessories"
        
        return [blankCategory1, blankCategory2, blankCategory3, blankCategory4]
    }()
}

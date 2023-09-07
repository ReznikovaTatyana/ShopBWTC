//
//  Data.swift
//  BwtcCoffeeShop
//
//  Created by mac on 15.05.2023.
//

import Foundation

struct Data {
    static let  shared = Data()
     private let promoImages: ListSection = {
         .promoImages([.init(title: "", image: "IMG_8454"),
                       .init(title: "", image: "IMG_8462")])
       
    }()
    private let popularProducts: ListSection = {
        .popularProducts([.init(title: "ethiopia", image: "ethiopia guji espresso 2")])
        
    }()
    
    var pageData: [ListSection] {
        [promoImages, popularProducts]
    }
}

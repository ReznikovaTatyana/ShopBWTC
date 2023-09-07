//
//  ListSection.swift
//  BwtcCoffeeShop
//
//  Created by mac on 15.05.2023.
//

import Foundation
enum ListSection {
    case promoImages([ListItem])
    case popularProducts([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .promoImages(let items),
                .popularProducts(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .promoImages(_):
            return ""
        case .popularProducts(_):
            return ""
        }
    }
}

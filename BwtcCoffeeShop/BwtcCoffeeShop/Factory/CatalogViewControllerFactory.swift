//
//  CatalogViewControllerFactory.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.11.2023.
//

import Foundation
import UIKit
class CatalogViewControllerFactory {
    static func createViewController(for category: Category) -> UIViewController {
        switch category.name {
        case "Coffee":
            return CoffeeViewController()
        case "Dripp":
            return DrippViewController()
        case "Tea":
            return TeaViewController()
        case "Accessories":
            return AccessoriesViewController()
        default:
            fatalError("Unsupported category: \(category.name)")
        }
    }
}

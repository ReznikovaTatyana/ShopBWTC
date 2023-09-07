//
//  UINavigVCExtention.swift
//  BwtcCoffeeShop
//
//  Created by mac on 22.04.2023.
//

import UIKit
let search = UISearchController()
extension UINavigationController {
    static var navigationVC: UINavigationController  {
        self.navigationVC.navigationItem.searchController = search
        search.searchBar.placeholder = "Search"
    }
}

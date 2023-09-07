//
//  MainTabBarViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 21.04.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearence()
        setupTabBar()
    }
    
    
    func setupTabBar() {
        
        let mainPageViewController = createController(vc: ViewController(), itemName: "Home" , itemImage: "house.fill")
        let catalogViewController = createController(vc: CatalogViewController(), itemName: "Shop", itemImage: "rectangle.grid.2x2")
        let basketViewController = createController(vc: BasketViewController(), itemName: "Bask", itemImage: "cart.fill")
        let profileViewController = createController(vc: ProfileViewController(), itemName: "Profile", itemImage: "person.fill")
    viewControllers = [mainPageViewController, catalogViewController, basketViewController, profileViewController]
    
    }
    
    
    
    
    func createController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {

        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        let navContoller = UINavigationController(rootViewController: vc)
        navContoller.tabBarItem = item
        navContoller.navigationBar.scrollEdgeAppearance = navContoller.navigationBar.standardAppearance
       
        
        return navContoller
    }
    
    
    
    private func setTabBarAppearence() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        tabBar.backgroundColor = .mainOragge
        
    }
    
    }
    
   


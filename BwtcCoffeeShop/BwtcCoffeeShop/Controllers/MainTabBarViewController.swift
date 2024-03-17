//
//  MainTabBarViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 21.04.2023.
//

import UIKit

//MARK: Клас для керування виглядом та поведінкою головного таббару.
class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearence()
        setupTabBar()
    }
    
 //MARK: Встановлює контролери для кожної вкладки в таббарі.
   private func setupTabBar() {
        let mainPageViewController = createController(vc: FirstScreenViewController(), itemName: "Home" , itemImage: "house.fill")
        let catalogViewController = createController(vc: CatalogViewController(), itemName: "Shop", itemImage: "rectangle.grid.2x2")
        let basketViewController = createController(vc: BasketViewController(), itemName: "Bask", itemImage: "cart.fill")
        let profileViewController = createController(vc: ProfileViewController(), itemName: "Profile", itemImage: "person.fill")
    viewControllers = [mainPageViewController, catalogViewController, basketViewController, profileViewController]
    
    }
    
    //MARK: Створює контролер з вкладкою для таббару та налаштовує його вигляд.
    private func createController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        let navContoller = UINavigationController(rootViewController: vc)
        navContoller.tabBarItem = item
        navContoller.navigationBar.scrollEdgeAppearance = navContoller.navigationBar.standardAppearance
        return navContoller
    }
    
    
    //MARK: Налаштовує зовнішній вигляд та елементи керування таббару.
    private func setTabBarAppearence() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .bwtcGrey
        tabBar.unselectedItemTintColor = .bwtcLightGrey
        tabBar.backgroundColor = .bwtcOragge
    }
}
    
   


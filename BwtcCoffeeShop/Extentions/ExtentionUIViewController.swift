//
//  ExtentionUIViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 22.04.2023.
//

import UIKit

extension UIViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = .mainOragge
    }
    
    func createCustomTitleView() -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        let imageLogo = UIImageView()
        let image = UIImage(named: "2023-04-23 11.19.26")
        imageLogo.image = image
        imageLogo.frame = CGRect(x: -70, y: 0, width: 100, height: 40)
        imageLogo.layer.cornerRadius = 21
        imageLogo.clipsToBounds = true
        view.addSubview(imageLogo)
        return view
        
        
    }
    
    func customSegment() -> UIBarButtonItem {
        var languageSegment = UISegmentedControl()
        let languagesArray = ["UA", "EN"]
        languageSegment = UISegmentedControl(items: languagesArray)
        languageSegment.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        languageSegment.backgroundColor = .clear
        languageSegment.selectedSegmentTintColor = .mainOragge
        let languageBarItem = UIBarButtonItem(customView: languageSegment)
        return languageBarItem
    }
    
    func createSearch() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
    }
    
    
}
extension UIViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       print(searchText)
       //var text = searchText.lowercased()
       
   }
}

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
        let titlelabel = UILabel()
        titlelabel.text = "b  w  t  c"
        titlelabel.textAlignment = .center
        titlelabel.textColor = .mainOragge
        titlelabel.font = UIFont.systemFont(ofSize: 44)
        titlelabel.frame = CGRect(x: 14, y: -7, width: 170, height: 50)
        view.addSubview(titlelabel)
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

extension UILabel {
    
  public func addUnderline() {
        attributedText = NSAttributedString(string: text ?? "" , attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue, .strikethroughColor: UIColor.red])
    }
    
    public  func removeUnderline() {
        attributedText = NSAttributedString(string: text ?? "" , attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue, .strikethroughColor: UIColor.clear])
    }
    
}

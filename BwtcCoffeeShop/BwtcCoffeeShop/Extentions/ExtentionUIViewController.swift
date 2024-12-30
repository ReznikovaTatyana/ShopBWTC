//
//  ExtentionUIViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 22.04.2023.
//

import UIKit


extension UIViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = .bwtcOragge
        let logoImageItem = createCustomTitleView()
        navigationItem.titleView = logoImageItem
        let backButton = UIBarButtonItem()
            backButton.title = "Назад"  // Текст кнопки "Back"
        backButton.tintColor = .bwtcGrey
        navigationItem.backBarButtonItem = backButton// Колір тексту кнопки "Back"
          
        
    }
    
    func createCustomTitleView() -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        let titlelabel = UILabel()
        titlelabel.text = "b  w  t  c"
        titlelabel.textAlignment = .center
        titlelabel.textColor = .bwtcOragge
        titlelabel.font = UIFont.systemFont(ofSize: 44)
        titlelabel.frame = CGRect(x: 14, y: -7, width: 170, height: 50)
        view.addSubview(titlelabel)
        return view
    }
    
    func createCustomTitleNBView(title: String) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        let titlelabel = UILabel()
        titlelabel.text = title
        titlelabel.textAlignment = .left
        titlelabel.textColor = .bwtcOragge
        titlelabel.font = UIFont.systemFont(ofSize: 20)
        titlelabel.frame = CGRect(x: 0, y: -20, width: 200, height: 50)
        let underlineView = UIView()
        underlineView.backgroundColor = .black
        view.addSubview(titlelabel)
        return view
    }
    
    func customSegment() -> UIBarButtonItem {
        var languageSegment = UISegmentedControl()
        let languagesArray = ["UA", "EN"]
        languageSegment = UISegmentedControl(items: languagesArray)
        languageSegment.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        languageSegment.backgroundColor = .clear
        languageSegment.selectedSegmentTintColor = .bwtcOragge
        let languageBarItem = UIBarButtonItem(customView: languageSegment)
        return languageBarItem
    }
    
    func createSearch() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .bwtcGrey
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        return searchController
    
        
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

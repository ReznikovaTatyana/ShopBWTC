//
//  CoffeeViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseDatabase
import FirebaseFirestore


class CoffeeViewController: UIViewController {
    
    var collectionViewCoffee: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = .init(top: 20, left: 10, bottom: 10, right: 10)
            layout.collectionView?.backgroundColor = .bwtcOragge
            layout.collectionView?.clipsToBounds = true
            layout.headerReferenceSize = .init(width: 400, height: 40)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
        }()
    
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No results found"
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true // Початково ховаємо мітку
        return label
    }()
    
    lazy var searchController = createSearch()
    lazy var contentCoffeeShopCell: ShopViewModel = ShopViewModel()
    let detailViewController = CoffeeDetailViewController()
    private var filterCategories = [Goods]()
   
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        addFirebase()
        createCustomNavigationBar()
    }
    
    
    func setupViews() {
        view.addSubview(collectionViewCoffee)
        createCollectionView()
        installNavigationBar()
        //create()
    }
    
    private func installNavigationBar() {
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    
    
    func addFirebase() {
        collectionViewCoffee.reloadData()
        self.contentCoffeeShopCell.updateGoodsFromFirebase { [weak self] in
            self?.collectionViewCoffee.reloadData()
            print(self?.contentCoffeeShopCell.packCoffeeArray.count ?? 0)
        }
            self.contentCoffeeShopCell.updateGoodsFromFirebaseBigPack { [weak self] in
                self?.collectionViewCoffee.reloadData()
                print(self?.contentCoffeeShopCell.bigPackArray.count ?? 0)
        }
    }
    
    
    
    func createCollectionView() {
        collectionViewCoffee.layer.shadowRadius = 10
       
        collectionViewCoffee.dataSource = self
        collectionViewCoffee.delegate = self
        collectionViewCoffee.reloadData()
        if #available(iOS 14.0, *) {
            collectionViewCoffee.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "\(ShopCollectionViewCell.self)")
        } else {
            // Fallback on earlier versions
        }
        collectionViewCoffee.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderCollectionReusableView.self)")
        
        collectionViewCoffee.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionViewCoffee.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionViewCoffee.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionViewCoffee.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionViewCoffee.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            collectionViewCoffee.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1)
        ])
    }
    
}

extension CoffeeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filterCategories.count
        } 
        return contentCoffeeShopCell.packCoffeeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if #available(iOS 14.0, *) {
            if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ShopCollectionViewCell.self)", for: indexPath) as? ShopCollectionViewCell {
                if isFiltering {
                    itemCell.shop = filterCategories[indexPath.row]
                } else {
                    itemCell.shop = contentCoffeeShopCell.packCoffeeArray[indexPath.row]
                }
                return itemCell
            }
        } else {
            // Fallback on earlier versions
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderCollectionReusableView.self)", for: indexPath) as? HeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            view.titleLabel.text = "Coffee"
            return view
        default: return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
       
            if let menu = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ShopCollectionViewCell.self)", for: indexPath) as? ShopCollectionViewCell {
                let shop: Goods
                if isFiltering {
                    menu.shop = filterCategories[indexPath.item]
                } else {
                    menu.shop  = contentCoffeeShopCell.packCoffeeArray[indexPath.item]
                }
                detailViewController.coffeeGoods =  menu.shop
                detailViewController.labelName.text = menu.coffeeNameLabel.text
                detailViewController.imageView.image = menu.coffeeImageView.image
                detailViewController.labelPrice.text = menu.coffeePriceLabel .text
                detailViewController.infoText.text = menu.textLabel.text
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        
        }
    }
            
            
extension CoffeeViewController:  UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

                        let coffeeCV = collectionViewCoffee
                        let screenWidth = coffeeCV.frame.width
                        let screenHeight = coffeeCV.bounds.height
                        let cellWidth = screenWidth * 0.45
            let cellHeight = screenHeight  * 0.5
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
        
extension CoffeeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        
        filterCategories = contentCoffeeShopCell.packCoffeeArray.filter({ (category: Goods) in
            return category.name!.lowercased().contains(searchText.lowercased())
        })
        
        collectionViewCoffee.reloadData()
        
        if filterCategories.isEmpty && !searchBarIsEmpty {
               noResultsLabel.isHidden = false // Показуємо мітку, якщо немає результатів
           } else {
               noResultsLabel.isHidden = true // Ховаємо мітку, якщо є результати
           }
      
           
    }
    
}

//
//  CatalogViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit

class CatalogViewController: UIViewController {
   
    
    var collectionViewCatalog: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 15
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = .init(top: 15, left: 10, bottom: 10, right: 10)
            layout.collectionView?.backgroundColor = .mainOragge
            layout.collectionView?.clipsToBounds = true
        return cv
        }()
   
    
    var categoryCollectionViewCell: CategoryCollectionViewCell = CategoryCollectionViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        createCollectionView()
        setupViews()
}
    
    private func setupViews() {
          createSearch()
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
    }
    
    
    func createCollectionView() {
        view.addSubview(collectionViewCatalog)
        collectionViewCatalog.frame = view.bounds
        collectionViewCatalog.backgroundColor = .white
        collectionViewCatalog.clipsToBounds = true
        collectionViewCatalog.dataSource = self
        collectionViewCatalog.delegate = self
        collectionViewCatalog.reloadData()
        collectionViewCatalog.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: "\(CatalogCollectionViewCell.self)")
        collectionViewCatalog.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionViewCatalog.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionViewCatalog.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionViewCatalog.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionViewCatalog.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            collectionViewCatalog.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1)
        ])
    }
    
}


extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryCollectionViewCell.contentCategoryCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CatalogCollectionViewCell.self)", for: indexPath) as? CatalogCollectionViewCell {
            itemCell.category = categoryCollectionViewCell.contentCategoryCell[indexPath.item]
            itemCell.catalogViewController = self
            return itemCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
        let coffeeViewController = CoffeeViewController()
        let drippViewController = DrippViewController()
        let teaViewController = TeaViewController()
        let accessoriesViewController = AccessoriesViewController()
        //let cell = categoryCollectionViewCell.contentCategoryCell[indexPath.item]
        switch indexPath.item {
        case 0 :
            navigationController?.pushViewController(coffeeViewController, animated: true)
        case 1 :
            navigationController?.pushViewController(drippViewController, animated: true)
        case 2:
            navigationController?.pushViewController(teaViewController, animated: true)
        case 3:
            navigationController?.pushViewController(accessoriesViewController, animated: true)
        default: break
            
        }
        
}
    
}

extension CatalogViewController:  UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

                        let collectionCV = collectionViewCatalog
                        let screenWidth = collectionCV.frame.width
                        let screenHeight = collectionCV.bounds.height
                        let cellWidth = screenWidth * 0.45
            let cellHeight = screenHeight  * 0.33
            return CGSize(width: cellWidth, height: cellHeight)

        }        
    }
    

    



    


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
        layout.collectionView?.clipsToBounds = true
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 15, left: 10, bottom: 10, right: 10)
        layout.collectionView?.backgroundColor = .mainOragge
        layout.collectionView?.clipsToBounds = true
        return cv
    }()
    
    
    var categoriesForCatalog: CategoriesForCatalogProtocol = CategoriesForCatalog()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        createSearch()
        createCollectionView()
        makeConstraints()
        let logoImageItem = createCustomTitleView()

        navigationItem.titleView = logoImageItem
    }
    
    
   private func createCollectionView() {
        view.addSubview(collectionViewCatalog)
        collectionViewCatalog.frame = view.bounds
        collectionViewCatalog.layer.shadowRadius = 10
        collectionViewCatalog.backgroundColor = .white
        //collectionViewCatalog.clipsToBounds = true
        collectionViewCatalog.dataSource = self
        collectionViewCatalog.delegate = self
        collectionViewCatalog.reloadData()
        collectionViewCatalog.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: "\(CatalogCollectionViewCell.self)")
        
    }
    
    func makeConstraints() {
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
        return categoriesForCatalog.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CatalogCollectionViewCell.self)", for: indexPath) as? CatalogCollectionViewCell {
            let category = categoriesForCatalog.categories[indexPath.item]
            itemCell.configure(with: category)
            return itemCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        let selectedCategory = categoriesForCatalog.categories[indexPath.item]
        navigateToCategory(selectedCategory)
    }
    
    private func navigateToCategory(_ category: Category) {
        let viewController = CatalogViewControllerFactory.createViewController(for: category)
        navigationController?.pushViewController(viewController, animated: true)
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









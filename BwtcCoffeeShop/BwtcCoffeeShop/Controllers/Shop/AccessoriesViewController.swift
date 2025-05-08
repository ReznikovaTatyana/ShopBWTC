//
//  AccessoriesViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit

class AccessoriesViewController: UIViewController {
    
    var accessoriesCollectionView: UICollectionView = {

            let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .vertical
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = .init(top: 20, left: 10, bottom: 10, right: 10)
                layout.collectionView?.backgroundColor = .bwtcOragge
                layout.collectionView?.clipsToBounds = true
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            return cv
        }()
    
    var drippCell: ShopViewModel = ShopViewModel()
    let detailViewController = AllDetailViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
        createSearch()
        createCollectionView()
        }
        
    func createCollectionView() {
        view.addSubview(accessoriesCollectionView)
        accessoriesCollectionView.backgroundColor = .white
        accessoriesCollectionView.frame = view.bounds
        accessoriesCollectionView.dataSource = self
        accessoriesCollectionView.delegate = self
        accessoriesCollectionView.reloadData()
        accessoriesCollectionView.register(DrippCollectionViewCell.self, forCellWithReuseIdentifier: "\(DrippCollectionViewCell.self)")
        accessoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accessoriesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            accessoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            accessoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            accessoriesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            accessoriesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1)
        ])
    }
}

extension AccessoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drippCell.accessoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DrippCollectionViewCell.self)", for: indexPath) as? DrippCollectionViewCell {
            itemCell.shop = drippCell.accessoriesArray[indexPath.item]
            itemCell.clipsToBounds = true
            itemCell.layer.cornerRadius = 12.0
            itemCell.layer.borderWidth = 0.0
            itemCell.layer.shadowColor = UIColor.bwtcGrey.cgColor
            itemCell.layer.shadowOffset = CGSize(width: 0, height: 0)
            itemCell.layer.shadowRadius = 4.0
            itemCell.layer.shadowOpacity = 1
            itemCell.layer.masksToBounds = false
            return itemCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let menuAccessories = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DrippCollectionViewCell.self)", for: indexPath) as? DrippCollectionViewCell {
            menuAccessories.shop = drippCell.accessoriesArray[indexPath.row]
            detailViewController.shop = menuAccessories.shop
            detailViewController.labelName.text = menuAccessories.drippName.text
            detailViewController.imageView.image = menuAccessories.drippImageView.image
            detailViewController.labelPrice.text = menuAccessories.drippPrice.text
            detailViewController.textLabel.text = menuAccessories.textLabel.text
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension AccessoriesViewController:  UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let accessoriesCV = accessoriesCollectionView
                let screenWidth = accessoriesCV.frame.width
                let screenHeight = accessoriesCV.bounds.height
                let cellWidth = screenWidth * 0.45
                let cellHeight = screenHeight  * 0.33
            return CGSize(width: cellWidth, height: cellHeight)

        }
    }

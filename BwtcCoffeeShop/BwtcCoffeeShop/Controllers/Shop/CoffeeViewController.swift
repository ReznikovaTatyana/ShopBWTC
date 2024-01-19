//
//  CoffeeViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit


class CoffeeViewController: UIViewController {
    
    var collectionViewCoffee: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = .init(top: 20, left: 10, bottom: 10, right: 10)
            layout.collectionView?.backgroundColor = .mainOragge
            layout.collectionView?.clipsToBounds = true
            layout.headerReferenceSize = .init(width: 400, height: 40)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
        }()
    
    var contentCoffeeShopCell: CoffeeSmallPacks = CoffeeSmallPacks()
    let detailViewController = CoffeeDetailViewController()
    lazy var sourse: [SectionCoffee] = [
        SectionCoffee(sectionName: "Pack 250gr", coffee: contentCoffeeShopCell.goods),
     SectionCoffee(sectionName: "Pack 1gr", coffee: contentCoffeeShopCell.bigPackArray) ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
        view.addSubview(collectionViewCoffee)
        createSearch()
        createCollectionView()
    }

    func createCollectionView() {
        collectionViewCoffee.layer.shadowRadius = 10
        collectionViewCoffee.dataSource = self
        collectionViewCoffee.delegate = self
        collectionViewCoffee.reloadData()
        collectionViewCoffee.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "\(ShopCollectionViewCell.self)")
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return contentCoffeeShopCell.goods.count
        case 1: return contentCoffeeShopCell.bigPackArray.count
        default: break
        }
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ShopCollectionViewCell.self)", for: indexPath) as? ShopCollectionViewCell {
            switch indexPath.section {
            case 0:
                itemCell.shop = contentCoffeeShopCell.goods[indexPath.item]
            case 1:
                itemCell.shop = contentCoffeeShopCell.bigPackArray[indexPath.item]
            default: break
            }
            
            return itemCell
            }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderCollectionReusableView.self)", for: indexPath) as? HeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            view.titleLabel.text = sourse[indexPath.section].sectionName
            return view
        default: return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
        if let menu = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ShopCollectionViewCell.self)", for: indexPath) as? ShopCollectionViewCell {
            switch indexPath.section {
            case 0:
                menu.shop = contentCoffeeShopCell.goods[indexPath.row]
                detailViewController.coffeeGoods = menu.shop
                detailViewController.labelName.text = menu.shopName.text
                detailViewController.imageView.image = menu.shopImageView.image
                detailViewController.labelPrice.text = menu.shopPrice.text
                detailViewController.textLabel.text = menu.textLabel.text
                     navigationController?.pushViewController(detailViewController, animated: true)
            case 1:
                menu.shop = contentCoffeeShopCell.bigPackArray[indexPath.row]
                detailViewController.coffeeGoods = menu.shop
                detailViewController.labelName.text = menu.shopName.text
                detailViewController.imageView.image = menu.shopImageView.image
                detailViewController.labelPrice.text = menu.shopPrice.text
                detailViewController.textLabel.text = menu.textLabel.text
                navigationController?.pushViewController(detailViewController, animated: true)
            default:
                break
            }
            
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
        
        
        



    
    

    
    

    
    







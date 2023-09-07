//
//  ViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
   
    let imagePageControl = UIPageControl()
    var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            imageCollectionView.backgroundView = .none
            imageCollectionView.bounces = false
            imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
                layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        return imageCollectionView
        }()
    
    var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let productsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
            layout.scrollDirection = .vertical
            layout.headerReferenceSize = .init(width: 250, height: 20)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
        return productsCollectionView
        }()
    
    
    var homeImage: HomeImage = HomeImage()
    var popularProducts: PopularProducts = PopularProducts()
    let detailViewController = CoffeeDetailViewController()
    lazy var section: [SectionCoffee] = [
        SectionCoffee(sectionName: "Популярні товари", coffee: popularProducts.popularProductsArray)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createSearch()
        setupViews()
        createImageCollectionView()
        createProductsCollectionView()
    }
    
    private func setupViews() {
        createCustomNavigationBar()
        createSearch()
        createImageCollectionView()
        createProductsCollectionView()
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
    }
    
   
    
    func createImageCollectionView() {
        view.addSubview(imageCollectionView)
     imageCollectionView.register(HomeImage.self, forCellWithReuseIdentifier: "HomeImage")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            imageCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1)
        ])
    }

    func createProductsCollectionView() {
        self.view.addSubview(productsCollectionView)
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        productsCollectionView.register(PopularProductsCell.self, forCellWithReuseIdentifier: "PopularProductsCell")
        productsCollectionView.register(HomeHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeHeaderCollectionReusableView")
        productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            productsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            productsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imagePageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
        return homeImage.seriesImages.count
        } else {
            return popularProducts.popularProductsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeImage", for: indexPath) as? HomeImage {
            cell.homeImage.image = UIImage(named: homeImage.seriesImages[indexPath.item])
            return cell
        }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularProductsCell", for: indexPath) as? PopularProductsCell {
                cell.products = popularProducts.popularProductsArray[indexPath.item]
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
        if let menu = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PopularProductsCell.self)", for: indexPath) as? PopularProductsCell {
            menu.products = popularProducts.popularProductsArray[indexPath.item]
            detailViewController.shop = menu.products
            detailViewController.labelName.text = menu.nameProducts.text
            detailViewController.imageView.image = menu.imageProducts.image
            detailViewController.labelPrice.text = menu.priceProducts.text
            detailViewController.textLabel.text = menu.text.text
                     navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderCollectionReusableView", for: indexPath) as? HomeHeaderCollectionReusableView {
                    return headerView
                }
            }
            return UICollectionReusableView()
        }

}

extension ViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == imageCollectionView {
                    let screenWidth = collectionView.bounds.width
                    let screenHeight = collectionView.bounds.height
                    return CGSize(width: screenWidth, height: screenHeight)
                } else {
                    let productsCV = productsCollectionView
                    let screenWidth = productsCV.frame.width
                    let screenHeight = productsCV.bounds.height
                    let cellWidth = screenWidth * 0.33
                    let cellHeight = screenHeight  * 0.33
                    return CGSize(width: cellWidth, height: cellHeight)
                }
    }
}



    

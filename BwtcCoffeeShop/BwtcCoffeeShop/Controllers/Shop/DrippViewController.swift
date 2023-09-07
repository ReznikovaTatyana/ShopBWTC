//
//  DrippViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit

class DrippViewController: UIViewController {
    
    var drippCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = .init(top: 20, left: 10, bottom: 10, right: 10)
            layout.collectionView?.backgroundColor = .mainOragge
            layout.collectionView?.clipsToBounds = true
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
        }()
    
    var drippCell: DrippCell = DrippCell()
    let detailViewController = AllDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
        view.addSubview(drippCollectionView)
        createSearch()
        createCollectionView()
    }
    
    func createCollectionView() {
        
        drippCollectionView.backgroundColor = .white
        drippCollectionView.frame = view.bounds
        drippCollectionView.dataSource = self
        drippCollectionView.delegate = self
        drippCollectionView.reloadData()
        drippCollectionView.register(DrippCollectionViewCell.self, forCellWithReuseIdentifier: "\(DrippCollectionViewCell.self)")
        drippCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drippCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            drippCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            drippCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            drippCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            drippCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1)
        ])
    }
}

extension DrippViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drippCell.drippArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DrippCollectionViewCell.self)", for: indexPath) as? DrippCollectionViewCell {
            itemCell.shop = drippCell.drippArray[indexPath.item]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let menuDripp = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DrippCollectionViewCell.self)", for: indexPath) as? DrippCollectionViewCell {
            menuDripp.shop = drippCell.drippArray[indexPath.row]
            detailViewController.shop = menuDripp.shop
            detailViewController.labelName.text = menuDripp.drippName.text
            detailViewController.imageView.image = menuDripp.drippImageView.image
            detailViewController.labelPrice.text = menuDripp.drippPrice.text
            detailViewController.textLabel.text = menuDripp.textLabel.text
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension DrippViewController:  UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                    let drippCV = drippCollectionView
                    let screenWidth = drippCV.frame.width
                    let screenHeight = drippCV.bounds.height
                    let cellWidth = screenWidth * 0.45
            let cellHeight = screenHeight  * 0.33
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }

//
//  TeaViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit

class TeaViewController: UIViewController {

        var teaCollectionView: UICollectionView = {
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
        
    var drippCell: ShopViewModel = ShopViewModel()
    let detailViewController = AllDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
        createSearch()
        createCollectionView()
        }
        
        func createCollectionView() {
            view.addSubview(teaCollectionView)
            teaCollectionView.backgroundColor = .white
            teaCollectionView.dataSource = self
            teaCollectionView.delegate = self
            teaCollectionView.reloadData()
            teaCollectionView.register(DrippCollectionViewCell.self, forCellWithReuseIdentifier: "\(DrippCollectionViewCell.self)")
            teaCollectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                teaCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                teaCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                teaCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                teaCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
                teaCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1)
            ])
        }
    }

    extension TeaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return drippCell.teaArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DrippCollectionViewCell.self)", for: indexPath) as? DrippCollectionViewCell {
                itemCell.shop = drippCell.teaArray[indexPath.item]
                itemCell.clipsToBounds = true
                itemCell.layer.cornerRadius = 12.0
                itemCell.layer.borderWidth = 0.0
                itemCell.layer.shadowColor = UIColor.tabBarItemAccent.cgColor
                itemCell.layer.shadowOffset = CGSize(width: 0, height: 0)
                itemCell.layer.shadowRadius = 4.0
                itemCell.layer.shadowOpacity = 1
                itemCell.layer.masksToBounds = false
                return itemCell
            }
            
            return UICollectionViewCell()
        }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let menuTea = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DrippCollectionViewCell.self)", for: indexPath) as? DrippCollectionViewCell {
                menuTea.shop = drippCell.teaArray[indexPath.row]
                detailViewController.shop = menuTea.shop
                detailViewController.labelName.text = menuTea.drippName.text
                detailViewController.imageView.image = menuTea.drippImageView.image
                detailViewController.labelPrice.text = menuTea.drippPrice.text
                detailViewController.textLabel.text = menuTea.textLabel.text
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }

extension TeaViewController:  UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let teaCV = teaCollectionView
                let screenWidth = teaCV.frame.width
                let screenHeight = teaCV.bounds.height
                let cellWidth = screenWidth * 0.45
                let cellHeight = screenHeight  * 0.33
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }

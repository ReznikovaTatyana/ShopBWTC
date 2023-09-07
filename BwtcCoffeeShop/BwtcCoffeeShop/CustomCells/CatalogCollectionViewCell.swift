//
//  CatalogCollectionViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit
import Foundation



class CatalogCollectionViewCell: UICollectionViewCell {
    var categoryImage = UIImageView()
    var categoryName = UILabel()
   weak var catalogViewController: CatalogViewController?
    
    var category: Category? {
        didSet {
            categoryName.text = category?.name
            if let image = category?.imageName {
                categoryImage.image = UIImage(named: image)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createcategoryImage()
        createcategoryName()
        self.backgroundColor = .white
        setupUI()
        awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
          contentView.layer.cornerRadius = 12.0
          contentView.layer.borderWidth = 0.0
          contentView.clipsToBounds = true
          contentView.layer.shadowColor = UIColor.tabBarItemAccent.cgColor
          contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
          contentView.layer.shadowRadius = 4.0
          contentView.layer.shadowOpacity = 1
          contentView.layer.masksToBounds = false
      }
    
    func createcategoryImage() {
        self.contentView.addSubview(categoryImage)
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        categoryImage.contentMode = .scaleToFill
        categoryImage.clipsToBounds = true
        NSLayoutConstraint.activate([
            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            categoryImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1
                                                 ),
            categoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func createcategoryName() {
        self.contentView.addSubview(categoryName)
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        NSLayoutConstraint.activate([
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryName.bottomAnchor.constraint(equalTo: categoryImage.bottomAnchor, constant: -15),
        ])
        categoryName.numberOfLines = 2
        categoryName.textAlignment = .center
        categoryName.textColor = .mainOragge
        categoryName.font = UIFont.systemFont(ofSize: 25)
    }
    
}





//
//  CatalllectionViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit

class CatalogCollectionViewCell: UICollectionViewCell {
    var catalogImageView = UIImageView()
    var catalogName = UILabel()
    
    var catalog: Catalog? {
        didSet {
            catalogName.text = catalog?.name
            if let image = catalog?.imageName {
                catalogImageView.image = UIImage(named: image)
            }
        }
    }
}

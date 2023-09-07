//
//  ShopCollectionViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit
class ShopCollectionViewCell: UICollectionViewCell {
    
    var shopImageView = UIImageView()
    var shopName = UILabel()
    var shopPrice = UILabel()
    
    
    var shop: Shop? {
        didSet {
            shopName.text = shop?.name
            shopPrice.text = shop?.price
            if let image = shop?.imageName{
                shopImageView.image = UIImage(named: image)
                }
            }
        }
}

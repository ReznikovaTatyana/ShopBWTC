//
//  PopularProductsCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 08.05.2023.
//

import UIKit

class PopularProductsCell: UICollectionViewCell {
   
    var imageProducts = UIImageView()
    var nameProducts = UILabel()
    var priceProducts = UILabel()
    var buyButton = UIButton()
    let text = UITextView()
    
    var container: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .yellow
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
   
    var products: Goods? {
        didSet {
            nameProducts.text = products?.name
            if let text = products?.price {
                priceProducts.text = "\(text)" + " UAN"
            }
            if let image = products?.imageName {
                imageProducts.image = UIImage(named: image)
                }
            text.text = products?.text
            }
        }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        createImage()
        createNameProducts()
        createPriceProducts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.contentView.addSubview(container)
        container.addArrangedSubview(imageProducts)
        container.addArrangedSubview(nameProducts)
        container.addArrangedSubview(priceProducts)
//        [imageProducts, nameProducts, priceProducts].forEach(container.addArrangedSubview)
       
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
               ])
    }
    
    func createImage() {
        imageProducts.translatesAutoresizingMaskIntoConstraints = false
        imageProducts.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            imageProducts.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imageProducts.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageProducts.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            imageProducts.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6)
        ])
    }
    
    
    func createNameProducts() {
       self.contentView.addSubview(nameProducts)
        nameProducts.translatesAutoresizingMaskIntoConstraints = false
        nameProducts.numberOfLines = 2
        nameProducts.textAlignment = .center
        nameProducts.textColor = .black
        nameProducts.font = UIFont.systemFont(ofSize: 10)
        NSLayoutConstraint.activate([
            nameProducts.centerYAnchor.constraint(equalTo: imageProducts.centerYAnchor, constant: 50),
            nameProducts.centerXAnchor.constraint(equalTo: priceProducts.centerXAnchor),
            nameProducts.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createPriceProducts() {
        self.contentView.addSubview(priceProducts)
        priceProducts.numberOfLines = 2
        priceProducts.font = UIFont.systemFont(ofSize: 13)
        priceProducts.textAlignment = .center
        priceProducts.textColor = .mainOragge
        priceProducts.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceProducts.centerXAnchor.constraint(equalTo: imageProducts.centerXAnchor),
            priceProducts.centerYAnchor.constraint(equalTo: imageProducts.centerYAnchor, constant: 70),
            priceProducts.heightAnchor.constraint(equalToConstant: 20)
        ])

    }
    
    
    
    
    
    }

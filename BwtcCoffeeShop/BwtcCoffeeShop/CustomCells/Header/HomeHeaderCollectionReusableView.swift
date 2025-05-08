//
//  HomeHeaderCollectionReusableView.swift
//  BwtcCoffeeShop
//
//  Created by mac on 16.05.2023.
//

import UIKit

class HomeHeaderCollectionReusableView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.bwtcLightGrey.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.text = "Популярні товари"
        label.textColor = .bwtcOragge
        label.textAlignment = .center
        label.backgroundColor = .bwtcLightGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupTitle() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

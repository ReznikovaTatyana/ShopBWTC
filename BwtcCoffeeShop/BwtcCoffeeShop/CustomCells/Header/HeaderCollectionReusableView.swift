//
//  HeaderCollectionReusableView.swift
//  BwtcCoffeeShop
//
//  Created by mac on 13.05.2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.tabBarItemLight.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.textColor = .mainOragge
        label.textAlignment = .center
        label.backgroundColor = .tabBarItemLight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
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
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}

//
//  ProfileTableViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 15.02.2024.
//

import UIKit

protocol ProfileCellProtocol {
    func configure(with profile: ProfileModel)
}

class ProfileTableViewCell: UITableViewCell {
    
    let imageProfileCell = UIImageView()
    let profileLabelCell = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
    }
    
    
    private func  setupView() {
        contentView.addSubview(imageProfileCell)
        contentView.addSubview(profileLabelCell)
        createImageLabel()
        createProfileLabel()
        makeConstraints()
    }
    
    private func createImageLabel() {
        imageProfileCell.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createProfileLabel() {
        profileLabelCell.translatesAutoresizingMaskIntoConstraints = false
        profileLabelCell.textColor = .tabBarItemAccent
        profileLabelCell.font = UIFont.systemFont(ofSize: 20)
        
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate ([
        imageProfileCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        imageProfileCell.heightAnchor.constraint(equalToConstant: 65),
        imageProfileCell.widthAnchor.constraint(equalToConstant: 70),
        imageProfileCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
        profileLabelCell.leadingAnchor.constraint(equalTo: imageProfileCell.trailingAnchor, constant: 10),
        profileLabelCell.widthAnchor.constraint(equalToConstant: 200),
        profileLabelCell.heightAnchor.constraint(equalToConstant: 50),
        profileLabelCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        profileLabelCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

}

extension ProfileTableViewCell: ProfileCellProtocol {
    func configure(with profile: ProfileModel) {
        profileLabelCell.text = profile.label
        imageProfileCell.image = UIImage(systemName: profile.image)
        imageProfileCell.tintColor = .tabBarItemAccent
    }
}


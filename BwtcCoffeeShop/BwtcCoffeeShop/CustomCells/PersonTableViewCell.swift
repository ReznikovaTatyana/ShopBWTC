//
//  PersonTableViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.03.2024.
//

import Foundation
import UIKit
import FirebaseAuth



class PersonTableViewCell: UITableViewCell {
    
        let imagePersonCell = UIImageView()
        let personLabelCell = UILabel()
   

        override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            setupView()
        }
    
        private func  setupView() {
            contentView.addSubview(imagePersonCell)
            contentView.addSubview(personLabelCell)
            createImageLabel()
            createProfileLabel()
            makeConstraints()
        }
        
        private func createImageLabel() {
            imagePersonCell.translatesAutoresizingMaskIntoConstraints = false
            imagePersonCell.tintColor = .bwtcOragge
        }
        
        private func createProfileLabel() {
            personLabelCell.translatesAutoresizingMaskIntoConstraints = false
            personLabelCell.textColor = .bwtcGrey
            personLabelCell.font = UIFont.systemFont(ofSize: 20)
            
        }
        
        private func makeConstraints() {
            NSLayoutConstraint.activate ([
                imagePersonCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
                imagePersonCell.heightAnchor.constraint(equalToConstant: 65),
                imagePersonCell.widthAnchor.constraint(equalToConstant: 70),
                imagePersonCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
                personLabelCell.leadingAnchor.constraint(equalTo: imagePersonCell.trailingAnchor, constant: 10),
                personLabelCell.widthAnchor.constraint(equalToConstant: 200),
                personLabelCell.heightAnchor.constraint(equalToConstant: 50),
                personLabelCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                personLabelCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    
    

    }



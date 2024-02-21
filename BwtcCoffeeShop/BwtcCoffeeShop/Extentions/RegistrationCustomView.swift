//
//  RegistrationCustomView.swift
//  BwtcCoffeeShop
//
//  Created by mac on 21.02.2024.
//

import Foundation
import UIKit

class RegistrationCustomView: UIControl {
    
    let labelCustomView = UILabel()
    let imageViewCustomView = UIImageView()
    let buttonCustomView = UIButton()
    let containerCustomView = UIView()
    
    weak var delegate: CustomViewDelegate?
        
    
    struct ContainerData {
        let labelText: String
    }
    
    var conteinerData: ContainerData
    
    init(conteinerData: ContainerData) {
        self.conteinerData = conteinerData
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(containerCustomView)
        addSubview(buttonCustomView)
        containerCustomView.addSubview(imageViewCustomView)
        containerCustomView.addSubview(labelCustomView)
        
        makeConstraints()
        createContainerCustomView()
        createImageViewCustomView()
        createLabelCustomView()
        createButtonCustomView()
    }
    
    private func createButtonCustomView() {
        buttonCustomView.addTarget(self, action: #selector( newUserButtonAction(_:)), for: .touchUpInside)
        buttonCustomView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func createLabelCustomView() {
        labelCustomView.translatesAutoresizingMaskIntoConstraints = false
        labelCustomView.text = conteinerData.labelText
        labelCustomView.textColor = .mainOragge
        labelCustomView.textAlignment = .left
        labelCustomView.font = UIFont.systemFont(ofSize: 18)
    }
    
    private func createImageViewCustomView() {
        imageViewCustomView.translatesAutoresizingMaskIntoConstraints = false
        imageViewCustomView.image = UIImage(systemName:  "chevron.right")
        imageViewCustomView.tintColor = .mainOragge
    }
    
    private func createContainerCustomView() {
        containerCustomView.translatesAutoresizingMaskIntoConstraints = false
        containerCustomView.backgroundColor = .clear
        containerCustomView.layer.borderWidth = 1.0
        containerCustomView.layer.cornerRadius = 7
        containerCustomView.layer.borderColor = UIColor.tabBarItemLight.cgColor
    }
    
    private func makeConstraints() {
       
        NSLayoutConstraint.activate([
            containerCustomView.widthAnchor.constraint(equalTo: widthAnchor),
            containerCustomView.heightAnchor.constraint(equalTo: heightAnchor),
            containerCustomView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buttonCustomView.topAnchor.constraint(equalTo: topAnchor),
            buttonCustomView.widthAnchor.constraint(equalTo: widthAnchor),
            buttonCustomView.heightAnchor.constraint(equalTo: heightAnchor),
            buttonCustomView.bottomAnchor.constraint(equalTo: bottomAnchor),
         
            labelCustomView.centerYAnchor.constraint(equalTo: containerCustomView.centerYAnchor),
            labelCustomView.heightAnchor.constraint(equalTo: containerCustomView.heightAnchor, multiplier: 0.8),
            labelCustomView.leadingAnchor.constraint(equalTo: containerCustomView.leadingAnchor, constant: 15),
            labelCustomView.widthAnchor.constraint(equalTo: containerCustomView.widthAnchor, multiplier: 0.6),
            
            imageViewCustomView.centerYAnchor.constraint(equalTo: containerCustomView.centerYAnchor),
            imageViewCustomView.heightAnchor.constraint(equalTo: containerCustomView.heightAnchor, multiplier: 0.65),
            imageViewCustomView.trailingAnchor.constraint(equalTo: containerCustomView.trailingAnchor, constant: -8),
            imageViewCustomView.widthAnchor.constraint(equalTo: containerCustomView.widthAnchor, multiplier: 0.08),
        ])
    }
    
    @objc func  newUserButtonAction(_ sender: UIButton) {
        switch conteinerData.labelText {
        case "Я новий користувач":  delegate?.didTapNewUserButton()
        case "У мене вже є акаунт": delegate?.didTapUserButton()
        default:
            break
        }
    }
    
}




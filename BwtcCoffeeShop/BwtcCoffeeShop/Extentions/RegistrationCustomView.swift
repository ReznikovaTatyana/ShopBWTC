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
        labelCustomView.textColor = .bwtcOragge
        labelCustomView.textAlignment = .left
        labelCustomView.font = UIFont.systemFont(ofSize: 18)
    }
    
    private func createImageViewCustomView() {
        imageViewCustomView.translatesAutoresizingMaskIntoConstraints = false
        imageViewCustomView.image = UIImage(systemName:  "chevron.right")
        imageViewCustomView.tintColor = .bwtcOragge
    }
    
    private func createContainerCustomView() {
        containerCustomView.translatesAutoresizingMaskIntoConstraints = false
        containerCustomView.backgroundColor = .clear
        containerCustomView.layer.borderWidth = 1.0
        containerCustomView.layer.cornerRadius = 7
        containerCustomView.layer.borderColor = UIColor.bwtcLightGrey.cgColor
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
        //case "Я новий користувач":  delegate?.didTapNewUserButton()
       // case "У мене вже є акаунт": delegate?.didTapUserButton()
        default:
            break
        }
    }
    
}


extension UITextField {
    
    public func setPlaceholderPadding() {
         let placeholderText = self.placeholder ?? ""
         let attributedPlaceholder = NSAttributedString(
             string: placeholderText,
             attributes: [
                 .font: self.font ?? UIFont.systemFont(ofSize: 17.0),
                 .foregroundColor: UIColor.bwtcLightGrey
             ]
         )
         self.attributedPlaceholder = attributedPlaceholder
     }
    
    public func updateTextFields(placeholder: String, view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        self.placeholder = placeholder
        textColor = .black
        layer.borderColor = UIColor.black.cgColor
        borderStyle = .roundedRect
        self.setPlaceholderPadding()
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)])
    }
}

extension UIButton {
    
    func customButton (title: String, view: UIView) {
        setTitle(title, for: .normal)
        setTitleColor(.bwtcLightGrey, for: .normal)
        backgroundColor = .bwtcOragge
        tintColor = .bwtcOragge
        layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension UINavigationController {
    func setupNavBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.bwtcOragge,
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.bwtcOragge,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.tintColor = .bwtcGrey
        UIBarButtonItem.appearance().tintColor = .bwtcGrey
        
    }
}


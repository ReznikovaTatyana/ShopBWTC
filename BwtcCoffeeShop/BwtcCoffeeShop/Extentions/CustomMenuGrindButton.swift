//
//  CustomMenuGrindButton.swift
//  BwtcCoffeeShop
//
//  Created by mac on 24.06.2024.
//

import Foundation
import UIKit

class CustomGrindRoastView: UIView {
    
   public var grindMenuButton = UIButton(type: .custom)
    public var roastMenuButton = UIButton(type: .custom)
    let grindModel = ModelGrind()
    let packArray = ["250гр", "1кг"]
    var grindMenuChildren: [UIMenuElement] = []
    var roastMenuChildren: [UIMenuElement] = []
   
    
    let actionClosure = { (action: UIAction) in
        print(action.title)
    }
    
    
   
   
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.bwtcGrey.cgColor
        addSubview(roastMenuButton)
        addSubview(grindMenuButton)
        grindMenuButton.setAttributedTitle(NSAttributedString(string: "Помел"), for: .normal)

        NSLayoutConstraint.activate([
            grindMenuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            roastMenuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            grindMenuButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55),
            roastMenuButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            roastMenuButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            grindMenuButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            
        ])
        
        createMenuButtons(button: roastMenuButton)
        createMenuButtons(button: grindMenuButton)
        createRoastMenuButton()
        createGrindMenuButton()
    }
    
    private func createMenuButtons(button: UIButton) {
        button.backgroundColor = .white
//        button.clipsToBounds = true
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 0.5
//        button.layer.borderColor = UIColor.bwtcGrey.cgColor
            var buttonConfig = UIButton.Configuration.plain()
            buttonConfig.titlePadding = 10
            buttonConfig.imagePadding = 10
            buttonConfig.imagePlacement = .trailing
        
    
            buttonConfig.baseForegroundColor = .bwtcOragge
            
            // Налаштування тексту і зображення
            buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            buttonConfig.titleAlignment = .leading
            buttonConfig.imagePadding = 20

            button.configuration = buttonConfig
        button.changesSelectionAsPrimaryAction = true
        button.contentHorizontalAlignment = .center
        button.tintColor = .bwtcOragge
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
//            button.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
        
        
       
        
    }
    
    private func createGrindMenuButton() {
       
        for grindCoffee in grindModel.tipeGrind {
         
            grindMenuChildren.append(UIAction(title: grindCoffee.grind, handler: actionClosure))
            }
        grindMenuButton.menu = UIMenu(options: .displayInline , children: grindMenuChildren)
        grindMenuButton.showsMenuAsPrimaryAction = true
        grindMenuButton.addTarget(self, action: #selector(showGrindMenu), for: .touchCancel)
      
        
       
    }
    
    
    private func createRoastMenuButton() {
        for grindCoffee in packArray {
         
            roastMenuChildren.append(UIAction(title: grindCoffee, handler: actionClosure))
            }
        roastMenuButton.menu = UIMenu(options: .displayInline , children: roastMenuChildren)
    }
    
    @objc func showGrindMenu() {
        
                    let menuItems = grindModel.tipeGrind.map { grind in
                        UIAction(title: grind.grind) { action in
                            self.grindMenuButton.setAttributedTitle(NSAttributedString(string: action.title), for: .normal)
                        }
                    }

            grindMenuButton.menu = UIMenu(options: .displayInline, children: menuItems)
            grindMenuButton.showsMenuAsPrimaryAction = true
    }
    
    
    @objc func showRoastMenu() {
       
        
    }
    
    
}



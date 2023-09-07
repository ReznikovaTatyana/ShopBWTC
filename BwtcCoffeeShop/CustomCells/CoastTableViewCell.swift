//
//  CoastTableViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 05.05.2023.
//

import UIKit

class CoastTableViewCell: UITableViewCell {
    
    var priceLabel = UILabel()
    var coastLabel = UILabel()
    var numberLabel = UILabel()
    var numberStepper  = UIStepper()
    var buyButton = UIButton()
   
    var itemNumber = "1" {
        didSet {
            numberLabel.text = itemNumber
        }
    }
    
    var itemCoast = "300" {
        didSet {
            coastLabel.text = itemCoast
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createPriceLabel()
        createNumberStepper()
        createBuyButton()
        createNumberLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createPriceLabel() {
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = itemCoast
        priceLabel.font = UIFont.systemFont(ofSize: 15)
        priceLabel.textColor = .mainOragge
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 37),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func createCoastLabel() {
        
        
        
    }
    
    func createNumberLabel(){
        self.contentView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.text = itemNumber
        numberLabel.textColor = .tabBarItemAccent
        numberLabel.font = UIFont.systemFont(ofSize: 20)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -7),
            numberLabel.widthAnchor.constraint(equalToConstant: 80),
            numberLabel.heightAnchor.constraint(equalToConstant: 40),
            numberLabel.leadingAnchor.constraint(equalTo: numberStepper.leadingAnchor, constant: 110),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        ])
        
    }
    
    func createNumberStepper() {
        self.contentView.addSubview(numberStepper)
        //numberStepper = UIStepper(frame: CGRect(x: 0, y: 0, width: 20, height: 25))
        //numberStepper.translatesAutoresizingMaskIntoConstraints = false
        numberStepper.minimumValue = 1
        numberStepper.maximumValue = 100
        numberStepper.value = 1
        numberStepper.frame = CGRect(x: 10, y: 0, width: 60, height: 25)
        numberStepper.addTarget(self, action: #selector(stepperAction(sender:)), for: .valueChanged)
        
        }
        
        @objc func stepperAction(sender: UIStepper) {
            itemNumber = "\(Int(sender.value))"
            itemCoast = "\(300 * Int(sender.value))"
            
        }
    func createBuyButton() {
        self.contentView.addSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        //self.clipsToBounds = true
        NSLayoutConstraint.activate([
            buyButton.widthAnchor.constraint(equalToConstant: 45),
            buyButton.heightAnchor.constraint(equalToConstant: 25),
            buyButton.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 100),
            //buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
           buyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            //buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        buyButton.setTitle("Buy", for: .normal)
       // buyButton.imageView = UIImage(systemName: "cart.fill")
        buyButton.setTitleColor(.tabBarItemLight, for: .normal)
        buyButton.backgroundColor = .mainOragge
        buyButton.tintColor = .mainOragge
        buyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buyButton.layer.cornerRadius = 7
        
    }
    
    @objc func buttonAction() {
        
    }
    
    
    
}

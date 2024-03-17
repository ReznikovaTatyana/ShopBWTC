//
//  BasketTableViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 02.06.2023.
//

import UIKit
import SwiftUI


protocol BasketTableViewCellDelegate: AnyObject {
    func didStepperValueChanged(_ cell: BasketTableViewCell, coast: Int, step: Int, label: UILabel)
}

class BasketTableViewCell: UITableViewCell {
    
    weak var delegate: BasketTableViewCellDelegate?
  
    var basketImageView = UIImageView()
    var nameLabel = UILabel()
    var opt = UILabel()
    var grindLabel = UILabel()
    var priceLabel = UILabel()
    var costLabel = UILabel()
    var customStepper = CustomStepper(viewData:  .init(color: .bwtcOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
    
    var costSaleLabel = UILabel()
       
    var position: BasketModel? {
        didSet {
            DispatchQueue.main.async {
                if let imageUrl = URL(string: self.position?.basketImageName ?? "") {
                    self.basketImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
                }
            }
            guard
                  let nameText = position?.basketName,
                  let grindText = position?.basketGrind,
                  let priceText = position?.basketPrice,
                  let stepper = position?.stepper,
                  let text = position?.coastSaleText,
                  let coast = position?.basketCoast else {return}
                costLabel.text = String(coast) + "грн"
                nameLabel.text = nameText
                grindLabel.text = grindText
                priceLabel.text = String(priceText) + "грн"
                costLabel.text = String(priceText * stepper) + "грн"
                costSaleLabel.text = text
                customStepper.firstValue = stepper
                customStepper.counterLabel.text = String(stepper)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        makeConstraints()
    }
    
   
    
    func setupView() {
        contentView.addSubview(basketImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(grindLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(costLabel)
        contentView.addSubview(customStepper)
        contentView.addSubview(costSaleLabel)
        createNameLabel()
        createCustomSteper()
        createGrindLabel()
        createPriceLabel()
        createCostSaleLabel()
        textFunc()
        makeConstraints()
    }
    
    private func createNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private  func createCustomSteper() {
        customStepper.addTarget(self, action: #selector(didStepperValueChanged(_:)), for: .valueChanged)
        customStepper.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createGrindLabel() {
        grindLabel.translatesAutoresizingMaskIntoConstraints = false
        grindLabel.font = UIFont.systemFont(ofSize: 14)
        grindLabel.textColor = .bwtcGrey
    }
    
    private func createPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .bwtcOragge
    }
    
    private func createCostSaleLabel() {
        costSaleLabel.translatesAutoresizingMaskIntoConstraints = false
        costSaleLabel.numberOfLines = 0
        costSaleLabel.textColor = .bwtcOragge
        costSaleLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func makeConstraints() {
        basketImageView.translatesAutoresizingMaskIntoConstraints = false
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            basketImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            basketImageView.heightAnchor.constraint(equalToConstant: 100),
            basketImageView.widthAnchor.constraint(equalToConstant: 100),
            basketImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: basketImageView.trailingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalToConstant: 110),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        
            grindLabel.leadingAnchor.constraint(equalTo: basketImageView.trailingAnchor, constant: 10),
            grindLabel.widthAnchor.constraint(equalToConstant: 90),
            grindLabel.heightAnchor.constraint(equalToConstant: 20),
            grindLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 45),
        
            priceLabel.leadingAnchor.constraint(equalTo: basketImageView.trailingAnchor, constant: 10),
            priceLabel.widthAnchor.constraint(equalToConstant: 70),
            priceLabel.heightAnchor.constraint(equalToConstant: 40),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 60),
        
            costLabel.leadingAnchor.constraint(equalTo: customStepper.leadingAnchor, constant: 90),
            costLabel.widthAnchor.constraint(equalToConstant: 90),
            costLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
           
            costSaleLabel.leadingAnchor.constraint(equalTo: customStepper.leadingAnchor, constant: 90),
            costSaleLabel.widthAnchor.constraint(equalToConstant: 90),
            costSaleLabel.topAnchor.constraint(equalTo: costLabel.topAnchor, constant: 25),
    
            customStepper.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 120),
            customStepper.widthAnchor.constraint(equalToConstant: 90),
            customStepper.heightAnchor.constraint(equalToConstant: 30),
            customStepper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40)
        ])
    }
    

    
    func textFunc() {
        if costSaleLabel.text != "" {
            costLabel.addUnderline()
          
        } else {
            costLabel.removeUnderline()
        }
    }
   
    
    @objc private func didStepperValueChanged(_ sender: UIStepper)  {
        guard let coast = position?.basketCoast,
             let text = position?.coastSaleText,
              let stepper = position?.stepper,
             // let optPrice = position?.basketSalePrice,
              let price = position?.basketPrice else {return}
        costLabel.text = String (price * stepper) + "грн"
        costSaleLabel.text = text
        textFunc()
        delegate?.didStepperValueChanged(self, coast: coast, step: customStepper.firstValue, label: costLabel)
       
}
    
}


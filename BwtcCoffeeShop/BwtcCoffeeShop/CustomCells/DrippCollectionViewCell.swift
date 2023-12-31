//
//  DrippCollectionViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 12.05.2023.
//

import UIKit

class DrippCollectionViewCell: UICollectionViewCell {

    var drippName: UILabel = {
        let name = UILabel()
        name.clipsToBounds = true
        name.numberOfLines = 0
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 18)
        return name
    }()
    
    var drippImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var drippPrice: UILabel = {
        let price = UILabel()
        price.numberOfLines = 1
        price.clipsToBounds = true
        price.textAlignment = .center
        price.font = UIFont.systemFont(ofSize: 15)
        price.font = UIFont.preferredFont(forTextStyle: .body)
        price.textColor = .mainOragge
        return price
    }()
    
    var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Купити", for: .normal)
        button.setTitleColor(.tabBarItemLight, for: .normal)
        button.backgroundColor = .mainOragge
        button.tintColor = .mainOragge
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    let customStepper: CustomStepper = {
        let stepper = CustomStepper(viewData: .init(color: .mainOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
        stepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    var textLabel = UILabel()
    var shop: Shop? {
        didSet {
            drippName.text = shop?.name
            if let text = shop?.price {
                drippPrice.text = "\(text) грн"
            }
            if let image = shop?.imageName {
                drippImageView.image = UIImage(named: image)
                }
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        setupView()
        makeConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
          contentView.layer.cornerRadius = 12.0
          contentView.layer.borderWidth = 0.0
          contentView.clipsToBounds = true
          contentView.layer.shadowColor = UIColor.tabBarItemAccent.cgColor
          contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
          contentView.layer.shadowRadius = 4.0
          contentView.layer.shadowOpacity = 1
          contentView.layer.masksToBounds = false
      }
    
    func setupView() {
        awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.contentView.addSubview(drippImageView)
        self.contentView.addSubview(drippName)
        self.contentView.addSubview(drippPrice)
        self.contentView.addSubview(buyButton)
        self.contentView.addSubview(customStepper)
    }
    
    func makeConstraints() {
        
        drippImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drippImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            drippImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.97),
            drippImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            drippImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
            drippName.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                drippName.topAnchor.constraint(equalTo: drippImageView.bottomAnchor, constant: 10),
                drippName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
                drippName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        drippPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drippPrice.topAnchor.constraint(equalTo: drippName.bottomAnchor, constant: 10),
            drippPrice.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            drippPrice.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        customStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customStepper.topAnchor.constraint(equalTo: drippPrice.bottomAnchor, constant: 10),
            customStepper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            customStepper.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.08),
            customStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6)
        ])
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: drippPrice.bottomAnchor, constant: 10),
            buyButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            buyButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.115),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6)
        ])
    }
    
    @objc func buttonAction() {
        guard let image = shop?.imageName else {return}
        guard let nameText = drippName.text  else {return}
        guard let price = shop?.price else {return}
        let position = BasketModel( basketImageName: image,
                                basketName: nameText,
                                basketGrind: "",
                                basketPrice: price,
                                    stepper: customStepper.firstValue,
                                    basketCoast: customStepper.firstValue * price)
        BasketViewModel.shared.addPosition(position: position)
        customStepper.firstValue = customStepper.resetValue(customStepper.firstValue)
        print(position.basketName)
        print(position.basketGrind)
        print(position)
    }
    
    @objc private func didStepperValueChanged() {
       
     }
    
}

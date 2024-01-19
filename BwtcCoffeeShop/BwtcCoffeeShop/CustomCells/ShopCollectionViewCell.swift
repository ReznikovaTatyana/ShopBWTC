//
//  ShopCollectionViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    var textLabel = UILabel()
    var pickerText = UILabel()
    var shopName: UILabel = {
        let labelName = UILabel()
        labelName.clipsToBounds = true
        labelName.numberOfLines = 0
        labelName.textAlignment = .center
        labelName.font = UIFont.systemFont(ofSize: 18)
        return labelName
    }()
    
    var shopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var shopPrice: UILabel = {
        let labelPrice = UILabel()
        labelPrice.clipsToBounds = true
        labelPrice.numberOfLines = 0
        labelPrice.textAlignment = .center
        labelPrice.font = UIFont.systemFont(ofSize: 15)
        labelPrice.font = UIFont.preferredFont(forTextStyle: .body)
        labelPrice.textColor = .mainOragge
        return labelPrice
    }()
    
    var grindLabel: UILabel = {
        let grindLabel = UILabel()
        grindLabel.text = "Помел"
        grindLabel.numberOfLines = 0
        grindLabel.textAlignment = .center
        grindLabel.font = UIFont.systemFont(ofSize: 14)
        grindLabel.textColor = .tabBarItemAccent
        return grindLabel
    }()
    
    var grindPicker = UIPickerView()
    
    var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Купити", for: .normal)
        button.setTitleColor(.tabBarItemLight, for: .normal)
        button.backgroundColor = .mainOragge
        button.tintColor = .mainOragge
        button.layer.cornerRadius = 12
        button.addTarget(ShopCollectionViewCell.self, action: #selector(buttonAction), for: .touchUpInside)
       return button
    }()
    
    let identifaer = "ShopCell"
    let grindModel = ModelGrind()
    let customStepper: CustomStepper = {
    let stepper = CustomStepper(viewData: .init(color: .mainOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
        stepper.addTarget(ShopCollectionViewCell.self, action: #selector(didStepperValueChanged), for: .valueChanged)
        return stepper
    }()
  
   
    var shop: Goods? {
        didSet {
            shopName.text = shop?.name
            if let text = shop?.price {
                shopPrice.text = "\(text)" + " UAN"
            }
            if let image = shop?.imageName {
                shopImageView.image = UIImage(named: image)
                }
            if let textLab = shop?.text {
                textLabel.text = textLab
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        makeConstraints()
        didStepperValueChanged()
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

    
    
     override func awakeFromNib() {
         super.awakeFromNib()
         contentView.layer.cornerRadius = 16
     }
    
    //MARK: Add elements to contentView
    func setupView() {
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.addSubview(shopImageView)
        contentView.addSubview(shopName)
        contentView.addSubview(shopPrice)
        contentView.addSubview(grindLabel)
        contentView.addSubview(grindPicker)
        contentView.addSubview(customStepper)
        contentView.addSubview(buyButton)
        grindPicker.delegate = self
        grindPicker.dataSource = self
    }
    
    
    
    func config(path: String) {
        if let url = URL(string: path),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            shopImageView.image = image
        }
    }
    
    // MARK: Add Constraints
    func makeConstraints() {
        shopImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shopImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            shopImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.97),
            shopImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.43),
            shopImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        shopName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shopName.topAnchor.constraint(equalTo: shopImageView.bottomAnchor, constant: 5),
            shopName.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            shopName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        shopPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shopPrice.topAnchor.constraint(equalTo: shopName.bottomAnchor, constant: 0),
            shopPrice.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            grindLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        grindLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grindLabel.topAnchor.constraint(equalTo: shopPrice.bottomAnchor, constant: 5),
            grindLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            grindLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        grindPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grindPicker.topAnchor.constraint(equalTo: grindLabel.bottomAnchor, constant: 0),
            grindPicker.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            grindPicker.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.14),
            grindPicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        customStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customStepper.topAnchor.constraint(equalTo: grindPicker.bottomAnchor, constant: 5),
            customStepper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            customStepper.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05),
            customStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6)
        ])
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: grindPicker.bottomAnchor, constant: 5),
            buyButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            buyButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.08),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6)
        ])
    }

    @objc func buttonAction() {

        guard let image = shop?.imageName,
              let nameText = shopName.text,
              let grindText = pickerText.text,
              let salePrice = shop?.optPrice,
              let countDrip = shop?.countDrip,
              let identifaer = shop?.identifaer,
              let mass = shop?.mass,
              let price = shop?.price else {return}
        let position = BasketModel(basketImageName: image,
                                   basketName: nameText,
                                   basketGrind: grindText ,
                                   basketPrice: price,
                                   stepper: customStepper.firstValue,
                                   basketCoast: price * customStepper.firstValue, basketSalePrice: salePrice,
                                   identifaer: identifaer,
                                   countDrip: countDrip,
                                   mass: mass)
        BasketViewModel.shared.addPosition(position: position)
        customStepper.firstValue = customStepper.resetValue(customStepper.firstValue)
        grindPicker.reloadAllComponents()
        resetPicker()
        print(position.basketName)
        print(position.basketGrind)
    }
    
    @objc private func didStepperValueChanged() {
        
     }
    
    func resetPicker() {
        grindPicker.selectRow(0, inComponent: 0, animated: true)
            pickerText.text = grindModel.tipeGrind[0].grind
    }
    
}


//MARK: UIPickerDataSourse / Delegate

extension ShopCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grindModel.tipeGrind.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let roast = grindModel.tipeGrind[row].grind
        pickerText.text = roast
        return roast
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRoast = grindModel.tipeGrind[row].grind
        pickerText.text = selectedRoast
    }



}

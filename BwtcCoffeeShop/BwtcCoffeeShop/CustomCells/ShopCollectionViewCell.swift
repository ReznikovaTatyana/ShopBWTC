//
//  ShopCollectionViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 23.04.2023.
//

import UIKit
import SDWebImage


class ShopCollectionViewCell: UICollectionViewCell {
    
    var textLabel = UILabel()
    var pickerText = UILabel()
    
    var roastArray: [String] = []
   
    var coffeeNameLabel = UILabel()
    var coffeeImageView = UIImageView()
    var coffeePriceLabel = UILabel()
    

    
   
    var roastSegment = UISegmentedControl()
    var buyButton = UIButton()
  
   // let identifaer = "ShopCell"
    let grindModel = ModelGrind()
    let customStepper = CustomStepper(viewData: .init(color: .bwtcOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
    let grindRoastView = CustomGrindRoastView()
    
    
     
   

        let actionClosure = { (action: UIAction) in
            print(action.title)
        }

        var menuChildren: [UIMenuElement] = []
 
   
    var shop: Goods? {
        didSet {
             coffeeNameLabel.text = shop?.name
            if let text = shop?.price {
              coffeePriceLabel.text = "\(text)" + " UAN"
            }
            if let image = shop?.imageName {
              coffeeImageView.image = UIImage(named: image)
                }

                if let imageUrl = URL(string: self.shop?.imageName ?? "") {
                    self.coffeeImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            }
            guard let shop = shop else { return }
            updateSegmentControl(with: shop.roast ?? [])
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
          contentView.layer.shadowColor = UIColor.bwtcGrey.cgColor
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
        createCoffeeImageView()
        createCoffeeNameTitle()
        createCoffeePriceLabel()
        createCustomRGView()
        
        createRoastSegment()
        createBuyButton()
        createCustomStepper()
        
        
       
       
       
        
    
        
        makeConstraints()
       
        
        
    }
    
    private func createCoffeeImageView() {
        coffeeImageView.contentMode = .scaleAspectFill
        coffeeImageView.layer.cornerRadius = 12
        coffeeImageView.backgroundColor = .blue
        coffeeImageView.clipsToBounds = true
        contentView.addSubview(coffeeImageView)
        
    }
    
    private func createCoffeeNameTitle() {
        coffeeNameLabel.clipsToBounds = true
        coffeeNameLabel.numberOfLines = 0
        coffeeNameLabel.textAlignment = .center
        coffeeNameLabel.backgroundColor = .yellow
        coffeeNameLabel.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(coffeeNameLabel)
    }
    
    private func createCoffeePriceLabel() {
        coffeePriceLabel.clipsToBounds = true
        coffeePriceLabel.numberOfLines = 2
        coffeePriceLabel.textAlignment = .center
        coffeePriceLabel.backgroundColor = .red
        coffeePriceLabel.font = UIFont.systemFont(ofSize: 15)
        coffeePriceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        coffeePriceLabel.textColor = .bwtcOragge
        contentView.addSubview(coffeePriceLabel)
    }
    
    private func createCustomRGView() {
        grindRoastView.backgroundColor = .green
        contentView.addSubview(grindRoastView)
    }
    
    func createRoastSegment() {
            roastSegment = UISegmentedControl(items: roastArray)
            roastSegment.backgroundColor = .clear
            roastSegment.selectedSegmentTintColor = .bwtcOragge
        contentView.addSubview(roastSegment)
        
        }
    private func updateSegmentControl(with items: [String]) {
            roastSegment.removeAllSegments()
            for (index, item) in items.enumerated() {
                roastSegment.insertSegment(withTitle: item, at: index, animated: false)
            }
            if !items.isEmpty {
                roastSegment.selectedSegmentIndex = 0
            }
        roastSegment.selectedSegmentIndex = UISegmentedControl.noSegment
        
        }
    
    
    
    
    
    
    private func createBuyButton() {
        buyButton.setTitle("Купити", for: .normal)
        buyButton.setTitleColor(.bwtcLightGrey, for: .normal)
        buyButton.backgroundColor = .bwtcOragge
        buyButton.tintColor = .bwtcOragge
        buyButton.configuration?.cornerStyle = .large
        
        buyButton.clipsToBounds = true
       
        buyButton.layer.cornerRadius = 12
        buyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        contentView.addSubview(buyButton)
    }
    
    private func createCustomStepper() {
        customStepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
        customStepper.backgroundColor = .brown
        contentView.addSubview(customStepper)
    }
    
    // MARK: Add Constraints
    func makeConstraints() {
       coffeeImageView.translatesAutoresizingMaskIntoConstraints = false
       coffeeNameLabel.translatesAutoresizingMaskIntoConstraints = false
      coffeePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        grindRoastView.translatesAutoresizingMaskIntoConstraints = false
        roastSegment.translatesAutoresizingMaskIntoConstraints = false
        customStepper.translatesAutoresizingMaskIntoConstraints = false
        buyButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
           
            
            coffeeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            coffeeImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.97),
            coffeeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.43),
            coffeeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            coffeeNameLabel.topAnchor.constraint(equalTo: coffeeImageView.bottomAnchor, constant: 5),
            coffeeNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            coffeeNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        
            coffeePriceLabel.topAnchor.constraint(equalTo: coffeeNameLabel.bottomAnchor, constant: 3),
            coffeePriceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            coffeePriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            grindRoastView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            grindRoastView.topAnchor.constraint(equalTo: coffeePriceLabel.bottomAnchor, constant: 10),
            grindRoastView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            grindRoastView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.08),
            
            roastSegment.topAnchor.constraint(equalTo: grindRoastView.bottomAnchor, constant: 10),
            roastSegment.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roastSegment.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            roastSegment.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.06),
          
            customStepper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            customStepper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            customStepper.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.07),
            customStepper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),

         
            buyButton.bottomAnchor.constraint(equalTo: customStepper.bottomAnchor),
            buyButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            buyButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.07),
            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6)
        ])
    }
    
    @objc func buttonAction() {
        guard let nameText = coffeeNameLabel.text,
              let image = shop?.imageName,
              let grindText = grindRoastView.grindMenuButton.titleLabel?.text,
              let salePrice = shop?.optPrice,
              let countDrip = shop?.countDrip,
              let identifaer = shop?.identifaer,
              let mass = shop?.mass,
              let countPackDrip = shop?.countPackDrip,
              let price = shop?.price else {return}
        let position = BasketModel(basketImageName: image,
                                   basketName: nameText,
                                   basketGrind: grindText ,
                                   basketPrice: price,
                                   stepper: customStepper.firstValue,
                                   basketCoast: price * customStepper.firstValue, basketSalePrice: salePrice,
                                   identifaer: identifaer,
                                   countDrip: countDrip, 
                                   countPackDrip: countPackDrip,
                                   mass: mass)
        BasketViewModel.shared.addPosition(position: position)
        
        customStepper.firstValue = customStepper.resetValue(customStepper.firstValue)
      
       // resetMenuButton()
        print(position.basketName)
        print(position.basketGrind)
        print(roastArray)
    }
    
    
    @objc private func didStepperValueChanged() {
        
     }
    
//    @objc func showMenu() {
//        
//                    let menuItems = grindModel.tipeGrind.map { grind in
//                        UIAction(title: grind.grind) { action in
//                            self.button.setAttributedTitle(NSAttributedString(string: action.title), for: .normal)
//                        }
//                    }
//
//                    button.menu = UIMenu(options: .displayInline, children: menuItems)
//                    button.showsMenuAsPrimaryAction = true
//    }
//
//    
//    
//    func resetMenuButton() {
//        button.setAttributedTitle(NSAttributedString(string: "Помел"), for: .normal)
//    }
//    
//    func actionClosure(action: UIAction) {
//            pickerText.text = "\(action.title)"
//            button.setTitle(pickerText.text, for: .normal)
//        }
    
    
}


//MARK: UIPickerDataSourse / Delegate

@available(iOS 14.0, *)
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




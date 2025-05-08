//
//  AllDetailViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 02.09.2023.
//

import UIKit

class AllDetailViewController: UIViewController {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var labelName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    var labelPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .bwtcOragge
        return label
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    var buyButton = UIButton()
      
    let customStepper = CustomStepper(viewData: .init(color: .bwtcOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
    
    let grindModel = ModelGrind()
    var shop: Goods?
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
   private func setupView() {
        view.addSubview(imageView)
        view.addSubview(labelName)
        view.addSubview(labelPrice)
        view.addSubview(textLabel)
        view.addSubview(buyButton)
        view.addSubview(customStepper)
        createBuyButton()
        createCustomStepper()
        makeConstraints()
    }

    private func createBuyButton() {
        buyButton.setTitle("Kупити", for: .normal)
        buyButton.setTitleColor(UIColor.bwtcLightGrey, for: .normal)
        buyButton.backgroundColor = .bwtcOragge
        buyButton.layer.cornerRadius = 12
        buyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    private  func createCustomStepper() {
        customStepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
    }
    
    func makeConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            labelName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            labelName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 15),
            labelPrice.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            labelPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
            
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 10),
            buyButton.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.4),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        customStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customStepper.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 10),
            customStepper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            customStepper.widthAnchor.constraint(equalTo: buyButton.widthAnchor, multiplier: 0.5),
            customStepper.heightAnchor.constraint(equalTo: buyButton.heightAnchor)
        ])
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: customStepper.bottomAnchor, constant: 15),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    @objc private func  buttonAction() {
            guard let image = shop?.imageName,
                  let name = shop?.name,
                  let salePrice = shop?.optPrice,
                  let identifaer = shop?.identifaer,
                  let countDrip = shop?.countDrip,
                  let mass = shop?.mass,
                  let countPackDrip = shop?.countPackDrip,
                  let price = shop?.price else {return}
            let position = BasketModel( basketImageName: image,
                                        basketName: name,
                                        basketGrind: "" ,
                                        basketPrice: price,
                                        stepper: customStepper.firstValue,
                                        basketCoast: price * customStepper.firstValue,
                                        basketSalePrice: salePrice,
                                        identifaer: identifaer,
                                        countDrip: countDrip,
                                        countPackDrip: countPackDrip,
                                        mass: mass)
        BasketViewModel.shared.addPosition(position: position)
        customStepper.firstValue = customStepper.resetValue(customStepper.firstValue)
        
    }
    
    
    
    @objc private func didStepperValueChanged() {
      // print("latest value: \(customStepper.firstValue)")
     }
}


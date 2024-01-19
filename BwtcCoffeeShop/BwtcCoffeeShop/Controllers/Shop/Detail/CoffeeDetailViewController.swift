//
//  CoffeeDetailViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.05.2023.
//
import SnapKit
import UIKit

protocol CoffeeDetailViewControllerProtocol {
    var coffeeGoods: Goods? { get set }
}
final class CoffeeDetailViewController: UIViewController, CoffeeDetailViewControllerProtocol {
   
    var coffeeGoods: Goods?
    
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
        label.textColor = .mainOragge
        return label
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kупити", for: .normal)
        button.setTitleColor(UIColor.tabBarItemLight, for: .normal)
        button.backgroundColor = .mainOragge
        button.layer.cornerRadius = 12
        button.addTarget(CoffeeDetailViewController.self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    var grindPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.frame = CGRect(x: 0, y: 240, width: 185, height: 55)
        return picker
    }()

    let customStepper: CustomStepper = {
        let stepper = CustomStepper(viewData: .init(color: .mainOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
        stepper.addTarget(CoffeeDetailViewController.self, action: #selector(didStepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    var pickerText = UILabel()
    let grindModel = ModelGrind()
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        grindPicker.delegate = self
        grindPicker.dataSource = self
        setupView()
        makeConstraints()
    }
    
    func setupView() {
        view.addSubview(imageView)
        view.addSubview(labelName)
        view.addSubview(labelPrice)
        view.addSubview(textLabel)
        view.addSubview(buyButton)
        view.addSubview(customStepper)
        view.addSubview(grindPicker)
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
        
        grindPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grindPicker.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 5),
            grindPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            grindPicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            grindPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
            
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: grindPicker.bottomAnchor, constant: 10),
            buyButton.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.4),
            buyButton.trailingAnchor.constraint(equalTo: grindPicker.trailingAnchor, constant: -10)
        ])
        
        customStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customStepper.topAnchor.constraint(equalTo: grindPicker.bottomAnchor, constant: 10),
            customStepper.leadingAnchor.constraint(equalTo: grindPicker.leadingAnchor, constant: 20),
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
    
    func resetPicker() {
        grindPicker.selectRow(0, inComponent: 0, animated: true)
            pickerText.text = grindModel.tipeGrind[0].grind
    }
    
    
    @objc private func  buttonAction() {
            guard let image = coffeeGoods?.imageName,
                  let name = coffeeGoods?.name,
                  let grindText = pickerText.text,
                  let salePrice = coffeeGoods?.optPrice,
                  let identifaer = coffeeGoods?.identifaer,
                  let countDrip = coffeeGoods?.countDrip,
                  let mass = coffeeGoods?.mass,
                  let price = coffeeGoods?.price else {return}
            let position = BasketModel( basketImageName: image,
                                        basketName: name,
                                        basketGrind: grindText ,
                                        basketPrice: price,
                                        stepper: customStepper.firstValue,
                                        basketCoast: price * customStepper.firstValue,
                                        basketSalePrice: salePrice,
                                        identifaer: identifaer,
                                        countDrip: countDrip,
                                        mass: mass)
        BasketViewModel.shared.addPosition(position: position)
        customStepper.firstValue = customStepper.resetValue(customStepper.firstValue)
        grindPicker.reloadAllComponents()
        resetPicker()
        
    }
    
    
    
    @objc private func didStepperValueChanged() {
      // print("latest value: \(customStepper.firstValue)")
     }
}

extension CoffeeDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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


    
   







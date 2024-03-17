//
//  CoffeeDetailViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.05.2023.
//

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
      
    var grindPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.frame = CGRect(x: 0, y: 240, width: 185, height: 55)
        return picker
    }()

    let customStepper = CustomStepper(viewData: .init(color: .bwtcOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
     
    
    var infoText = UILabel()
    let scrollView = UIScrollView()
    //let contentView = UIView()
    
    var pickerText = UILabel()
    let grindModel = ModelGrind()
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        grindPicker.delegate = self
        grindPicker.dataSource = self
        view.addSubview(scrollView)
        createView()
        setupView()
        setupText()
        addToScrollView()
        makeConstraints()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupText()
    }
    
    func setupView() {
        createBuyButton()
        createCustomStepper()
        
    }
    
    private func createBuyButton() {
        buyButton.setTitle("Kупити", for: .normal)
        buyButton.setTitleColor(UIColor.bwtcLightGrey, for: .normal)
        buyButton.backgroundColor = .bwtcOragge
        buyButton.layer.cornerRadius = 12
        buyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    private func createCustomStepper() {
        customStepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
    }
    
   func createView() {
     //  contentView.translatesAutoresizingMaskIntoConstraints = false
         // scrollView.addSubview(contentView)
       scrollView.addSubview(imageView)
       scrollView.addSubview(labelName)
       scrollView.addSubview(labelPrice)
       scrollView.addSubview(buyButton)
       scrollView.addSubview(customStepper)
       scrollView.addSubview(grindPicker)
       scrollView.addSubview(infoText)
        
    }
    func setupText() {
        
        infoText.text = coffeeGoods?.text
        infoText.textAlignment = .left
        infoText.font = .systemFont(ofSize: 18)
        infoText.numberOfLines = 0
        guard let coffeeText = coffeeGoods?.text else {return}
        rangesTextToChangeColor(textToRanges: coffeeText)
    }
    
   
        func  attributedText(text: String, ranges: [String]) {
                let attributed = NSMutableAttributedString(string: text)
                for  rangeString in ranges {
                    let range = (text as NSString).range(of: rangeString)
                    attributed.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 19), range: range)
                }
               infoText.attributedText = attributed
    }
    
    func rangesTextToChangeColor(textToRanges: String) {
            let ranges = ["Регіон:", "Вид:", "Обробка:", "Смаковий профіль:", "Kраїна:"]
        attributedText(text: textToRanges, ranges: ranges)
        }

    
    func addToScrollView() {
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
  }

    func makeConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
                    imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.33),
                    imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
                    imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
                ])
                
                labelName.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
                    labelName.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
                    labelName.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
                ])
                
                labelPrice.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    labelPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 15),
                    labelPrice.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
                    labelPrice.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
                ])
                
                grindPicker.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    grindPicker.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 5),
                    grindPicker.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
                    grindPicker.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.08),
                    grindPicker.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
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
                
//                textLabel.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    textLabel.topAnchor.constraint(equalTo: customStepper.bottomAnchor, constant: 15),
//                    textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//                    textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//                ])
        infoText.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            infoText.topAnchor.constraint(equalTo: customStepper.bottomAnchor, constant: 15),
                            infoText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                            infoText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                            infoText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
                        ])
//
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
                  let countPackDrip = coffeeGoods?.countPackDrip,
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
                                        countPackDrip: countPackDrip,
                                        mass: mass)
        BasketViewModel.shared.addPosition(position: position)
        customStepper.firstValue = customStepper.resetValue(customStepper.firstValue)
        grindPicker.reloadAllComponents()
        resetPicker()
    }
    
    
    
    @objc private func didStepperValueChanged() {
      
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


    
   







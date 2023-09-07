//
//  CustomStepper.swift
//  BwtcCoffeeShop
//
//  Created by mac on 25.05.2023.
//

import UIKit
import SnapKit

class CustomStepper: UIControl {
   
    var plusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTappedPlus(_:)), for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.tabBarItemLight, for: .normal)
        button.backgroundColor = .mainOragge
        button.tintColor = .mainOragge
        return button
    }()
    
    var minusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTappedMinus(_:)), for: .touchUpInside)
        button.setTitle("-", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.tabBarItemLight, for: .normal)
        button.backgroundColor = .mainOragge
        button.tintColor = .mainOragge
        return button
    }()
   
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "1"
        return label
    }()
    
   var firstValue = 1
    
    private lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        return stack
        
    }()
    
    struct ViewData {
        let color: UIColor
        let minimum: Int
        let maximum: Int
        let stepValue: Int
        var value: Int
    }
    

    private var viewData: ViewData
    
    init(viewData: ViewData) {
        self.viewData = viewData
        super.init(frame: .zero)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        backgroundColor = .white
        addSubview(container)
        container.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        [minusButton, counterLabel, plusButton].forEach(container.addArrangedSubview)
    }
    

    func updateValuePlus(_ value: Int) {
        firstValue = value
        if firstValue < viewData.maximum {
            firstValue += viewData.stepValue
       }
        counterLabel.text = String(firstValue)
        sendActions(for: .valueChanged)
    }

    
    func updateValueMinus(_ value: Int) {
        firstValue = value
        if firstValue < viewData.maximum, firstValue > viewData.minimum {
            firstValue -= viewData.stepValue
        }
        counterLabel.text = String(firstValue)
        sendActions(for: .valueChanged)
    }
    
    func resetValue(_ value: Int)-> Int {
        var resetValue = value
        resetValue = 1
        counterLabel.text = String(resetValue)
        return resetValue
    }
    

    
    
    @objc private func buttonTappedPlus(_ sender: UIButton) {
        updateValuePlus(firstValue)
      }
    
    @objc private func buttonTappedMinus(_ sender: UIButton) {
        updateValueMinus(firstValue)
      }
    
}

 

//
//  BasketTableViewCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 02.06.2023.
//

import UIKit
import SnapKit


protocol BasketTableViewCellDelegate: class {
    func didStepperValueChanged(_ cell: BasketTableViewCell, coast: Int, step: Int)
}

class BasketTableViewCell: UITableViewCell {
    
    weak var delegate: BasketTableViewCellDelegate?
    var basketImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var nameLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: 14)
        return name
    }()
    var opt = UILabel()
    
    var grindLabel: UILabel = {
        let grind = UILabel()
        grind.font = UIFont.systemFont(ofSize: 14)
        grind.textColor = .tabBarItemAccent
        return grind
    }()
    
    var priceLabel: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 14)
        price.textColor = .mainOragge
        return price
    }()
    
    var costLabel: UILabel = {
        let cost = UILabel()
        return cost
    }()
    
    var customStepper: CustomStepper = {
        let stepper = CustomStepper(viewData: .init(color: .mainOragge, minimum: 1, maximum: 100, stepValue: 1, value: 1))
        stepper.addTarget(self, action: #selector(didStepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    var wrLabel: UILabel = {
        let wr = UILabel()
        wr.numberOfLines = 0
        wr.font = UIFont.systemFont(ofSize: 14)
        return wr
    }()
    
  
    
    var position: BasketModel? {
        didSet {
            if let image = position?.basketImageName {
                basketImageView.image = UIImage(named: image)
            }
            if let text = position?.basketName {
                nameLabel.text = text
            }
            if let text = position?.basketGrind {
                grindLabel.text = text
                
            }
            if let text1 = position?.basketPrice {
                priceLabel.text = String(text1) + "грн"
            }
            if let text = position?.basketCoast {
                costLabel.text = String(text) + "грн"
            }
            
            if let stepper = position?.stepper {
                customStepper.firstValue = stepper
               
                customStepper.counterLabel.text = String(stepper)
            }
            
            if let coast = position?.basketCoast {
                costLabel.text = String(coast) + "грн"
        }
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
    }
    
    func makeConstraints() {
        basketImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.top.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(basketImageView).inset(105)
            make.width.equalTo(110)
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(5)
        }
        grindLabel.snp.makeConstraints { make in
            make.left.equalTo(basketImageView).inset(105)
            make.width.equalTo(90)
            make.height.equalTo(20)
            make.top.equalTo(nameLabel).inset(45)
        }
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(basketImageView).inset(105)
            make.width.equalTo(70)
            make.height.equalTo(40)
            make.top.equalTo(nameLabel).inset(60)
        }
        costLabel.snp.makeConstraints { make in
            make.left.equalTo(customStepper).inset(90)
            make.width.equalTo(90)
            make.top.equalToSuperview().inset(45)
        }
        customStepper.snp.makeConstraints { make in
            make.left.equalTo(priceLabel).inset(120)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.top.equalToSuperview().inset(40)
        }
    }
    
   
    func updateCoast(coast:Int) {
        let newCoast = String (coast)
        costLabel.text = newCoast + "грн"
        }

    func newCoast(coast:Int) {
        if var position = position {
            //position.basketCoast = coast
        }
    }
       
    
    @objc private func didStepperValueChanged(_ sender: UIStepper)  {
        guard var coast = position?.basketCoast else {return}
        guard let price = position?.basketPrice else {return}
        coast = price * customStepper.firstValue
        updateCoast(coast: coast)
        newCoast(coast: coast)
        delegate?.didStepperValueChanged(self, coast: coast, step: customStepper.firstValue)
        print(customStepper.firstValue)
        print(coast)
}

}

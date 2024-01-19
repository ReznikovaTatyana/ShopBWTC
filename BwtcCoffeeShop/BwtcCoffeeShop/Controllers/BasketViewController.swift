//
//  BasketViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit

class BasketViewController: UIViewController {
    
    
    var basketViewModel: BasketViewModel = BasketViewModel.shared
    var totalCoast = 0
    var saleTotalCoast = 0
    
    var myTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 110
        table.register(BasketTableViewCell.self, forCellReuseIdentifier: "BasketTableViewCell")
        return table
    }()
    
    var orderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.tabBarItemLight.cgColor
        view.layer.borderWidth = 2.0
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    var summLabelText: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.text = "Сума:"
        return label
    }()
    
   lazy var summLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .mainOragge
        label.text = "\(totalCoast) грн"
        return label
    }()
    
    lazy var saleSummLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 18)
         label.textColor = .mainOragge
         label.text = "\(saleTotalCoast) грн"
         return label
     }()
    
    var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Замовити", for: .normal)
        button.setTitleColor(.tabBarItemLight, for: .normal)
        button.backgroundColor = .mainOragge
        button.tintColor = .mainOragge
        button.layer.cornerRadius = 12
        button.addTarget(BasketViewController.self, action: #selector(orderButtonAction), for: .touchUpInside)
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        myTableView.delegate = self
        myTableView.dataSource = self
        setupViews()

}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
    }
    
    
     func setupViews() {
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
         view.addSubview(myTableView)
         view.addSubview(orderView)
         orderView.addSubview(summLabel)
         orderView.addSubview(summLabelText)
         orderView.addSubview(saleSummLabel)
         orderView.addSubview(orderButton)
         constraints()
    }
    
    func constraints() {
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myTableView.bottomAnchor.constraint(equalTo: orderView.topAnchor),
            myTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            myTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        orderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0),
            orderView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1),
            orderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            orderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        summLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summLabel.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.25),
            summLabel.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.2),
            summLabel.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 20),
            summLabel.topAnchor.constraint(equalTo: summLabelText.bottomAnchor, constant: 15)
        ])
        
        saleSummLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saleSummLabel.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.25),
            saleSummLabel.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.2),
            saleSummLabel.leadingAnchor.constraint(equalTo: summLabel.trailingAnchor, constant: 20),
            saleSummLabel.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 25)
        ])
        
        summLabelText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summLabelText.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.25),
            summLabelText.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.2),
            summLabelText.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 15),
            summLabelText.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 15)
        ])
        
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderButton.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.4),
            orderButton.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.5),
            orderButton.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -10),
            orderButton.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 20)
        ])
    }
    
    @objc func orderButtonAction() {
        
    }
    
    private func updateTotalCost() {
        saleTotalCoast = basketViewModel.calculateSaleTotalCost()
            //summLabel.text = "\(totalCoast) грн"
            saleSummLabel.text = "\(saleTotalCoast) грн"
        
        }
    
    private func updateText() {
        if totalCoast == saleTotalCoast {
            saleSummLabel.text = ""
        }
    }
    
    
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketViewModel.positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as? BasketTableViewCell {
            cell.position = basketViewModel.positions[indexPath.item]
            totalCoast = basketViewModel.positions.reduce(0) { $0 + $1.basketPrice * $1.stepper }
            summLabel.text = "\(totalCoast) грн"
            updateTotalCost()
            updateText()
            cell.delegate = self
            return cell
        }
            return UITableViewCell()
            
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            basketViewModel.removePosition(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTotalCost()
            tableView.reloadData()
        }
    }
    
    
}

extension BasketViewController: BasketTableViewCellDelegate {
    
    func didStepperValueChanged(_ cell: BasketTableViewCell, coast: Int, step: Int, label: UILabel) {
        guard let index = myTableView.indexPath(for: cell) else { return }
        basketViewModel.positions[index.row].stepper = step
        basketViewModel.positions[index.row].basketCoast = coast
        
        

//        if (basketViewModel.positions.reduce(0, { $0 + $1.mass * $1.stepper})) >= 3000 {
//                    // Применить перечеркивание
//                    label.attributedText = NSAttributedString(
//                        string: label.text ?? "",
//                        attributes: [
//                            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
//                            .strikethroughColor: UIColor.red,])
//            myTableView.reloadData()
//                } else {
//                    print("Removing strikethrough")
//                    // Убрать перечеркивание
//                    label.attributedText = nil
//                    myTableView.reloadData()
//                }
                

        updateTotalCost()
        summLabel.text = "\(totalCoast) грн"
        myTableView.reloadData()
        BasketModel.save(basketViewModel.positions)
    }
}

extension BasketViewController: UIPickerViewDelegate {
    
}
    



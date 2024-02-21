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
    
    var orderView = UIView()
    var summLabelText = UILabel()
    var summCoastLabel = UILabel()
    var saleSummCoastLabel = UILabel()
    var orderButton = UIButton()
      
    
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
        let logoImageItem = createCustomTitleView()
        navigationItem.titleView = logoImageItem
         view.addSubview(myTableView)
         view.addSubview(orderView)
         orderView.addSubview(summCoastLabel)
         orderView.addSubview(summLabelText)
         orderView.addSubview(saleSummCoastLabel)
         orderView.addSubview(orderButton)
         makeConstraints()
         createOrderView()
         createSaleSummLabel()
         createSummLabel()
         createSummLabelText()
         createOrderButton()
    }
    
    private func createOrderView() {
        orderView.layer.borderColor = UIColor.tabBarItemLight.cgColor
        orderView.layer.borderWidth = 2.0
        orderView.clipsToBounds = true
        orderView.layer.cornerRadius = 20
        orderView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func createSummLabel() {
        summCoastLabel.textAlignment = .center
        summCoastLabel.font = .systemFont(ofSize: 18)
        summCoastLabel.textColor = .black
        summCoastLabel.text = "\(totalCoast) грн"
        summCoastLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createSaleSummLabel() {
        saleSummCoastLabel.textAlignment = .center
        saleSummCoastLabel.font = .systemFont(ofSize: 18)
        saleSummCoastLabel.textColor = .mainOragge
        saleSummCoastLabel.text = "\(saleTotalCoast) грн"
        saleSummCoastLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createOrderButton() {
        orderButton.setTitle("Замовити", for: .normal)
        orderButton.setTitleColor(.tabBarItemLight, for: .normal)
        orderButton.backgroundColor = .mainOragge
        orderButton.tintColor = .mainOragge
        orderButton.layer.cornerRadius = 12
        orderButton.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createSummLabelText() {
        summLabelText.textAlignment = .center
        summLabelText.font = .systemFont(ofSize: 18)
        summLabelText.text = "Сума:"
        summLabelText.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func makeConstraints() {
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myTableView.bottomAnchor.constraint(equalTo: orderView.topAnchor),
            myTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            myTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myTableView.topAnchor.constraint(equalTo: view.topAnchor),
       
            orderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0),
            orderView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  1),
            orderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            orderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            summCoastLabel.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.25),
            summCoastLabel.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.2),
            summCoastLabel.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 20),
            summCoastLabel.topAnchor.constraint(equalTo: summLabelText.bottomAnchor, constant: 15),
      
            saleSummCoastLabel.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.25),
            saleSummCoastLabel.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.2),
            saleSummCoastLabel.leadingAnchor.constraint(equalTo: summCoastLabel.trailingAnchor, constant: 5),
            saleSummCoastLabel.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 25),
        
            summLabelText.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.25),
            summLabelText.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.2),
            summLabelText.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 15),
            summLabelText.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 15),
    
            orderButton.widthAnchor.constraint(equalTo: orderView.widthAnchor, multiplier:  0.4),
            orderButton.heightAnchor.constraint(equalTo: orderView.heightAnchor, multiplier: 0.5),
            orderButton.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -10),
            orderButton.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 20)
        ])
    }
    
    @objc func orderButtonAction() {
        let viewController = RegistrationViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func updateTotalCost() {
        saleTotalCoast = basketViewModel.calculateSaleTotalCost()
            //summLabel.text = "\(totalCoast) грн"
        saleSummCoastLabel.text = "\(saleTotalCoast) грн"
        
        }
    
    private func updateText() {
        if totalCoast == saleTotalCoast {
            saleSummCoastLabel.text = ""
            summCoastLabel.removeUnderline()
           
        } else {
            summCoastLabel.addUnderline()
         
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
            summCoastLabel.text = "\(totalCoast) грн"
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
        updateTotalCost()
        summCoastLabel.text = "\(totalCoast) грн"
       // BasketViewModel.shared.attributedLabel(label: summLabel)
        myTableView.reloadData()
        BasketModel.save(basketViewModel.positions)
       
    }
}

extension BasketViewController: UIPickerViewDelegate {
    
}
    




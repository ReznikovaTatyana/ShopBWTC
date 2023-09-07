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
    
    var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Замовити", for: .normal)
        button.setTitleColor(.tabBarItemLight, for: .normal)
        button.backgroundColor = .mainOragge
        button.tintColor = .mainOragge
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
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
    
    
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketViewModel.positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as? BasketTableViewCell {
            cell.position = basketViewModel.positions[indexPath.item]
            totalCoast =  basketViewModel.positions.reduce(0) { $0 + $1.basketCoast}
            summLabel.text = "\(totalCoast) грн"
            cell.delegate = self
            return cell
        }
            return UITableViewCell()
            
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            basketViewModel.positions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    
}

extension BasketViewController: BasketTableViewCellDelegate {
    func didStepperValueChanged(_ cell: BasketTableViewCell, coast: Int, step: Int) {
        if let index = myTableView.indexPath(for: cell) {
            basketViewModel.positions[index.row].stepper = step
            basketViewModel.positions[index.row].basketCoast = coast
        BasketModel.save(basketViewModel.positions)
            totalCoast = basketViewModel.positions.reduce(0) { $0 + $1.basketCoast}
            summLabel.text = "\(totalCoast) грн"
    }
    }
    }

extension BasketViewController: UIPickerViewDelegate {
    
}
    



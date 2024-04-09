//
//  BasketViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit

//MARK: - Клас екрану корзини, на якому відображається таблиця з товарами доданими у корзину та загальна сума замовлення
class BasketViewController: UIViewController {
    
    //MARK: - Об'єкт для керування елементамі корзини
    var basketViewModel: BasketViewModel = BasketViewModel.shared
   
    //MARK: - Об'єкт для підрахунку суми всих замовлень
    var totalCoast = 0
    
    //MARK: - Об'єкт для підрахунку суми всих замовлень з оптовою ціною
    var saleTotalCoast = 0
    
    //MARK: - Таблиця для відображення доданиї товарів у корзину
    var myTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 110
        table.register(BasketTableViewCell.self, forCellReuseIdentifier: "BasketTableViewCell")
        table.isUserInteractionEnabled = true
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
    
    //MARK: -  Метод для додавання обєктів та розвантаження viewDidLoad
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
    
    //MARK: - Метод для створення та налаштування вью з сумою замовлення та переходом до оформелення замовлення
    private func createOrderView() {
        orderView.layer.borderColor = UIColor.bwtcLightGrey.cgColor
        orderView.layer.borderWidth = 2.0
        orderView.clipsToBounds = true
        orderView.layer.cornerRadius = 20
        orderView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    //MARK: - Метод для налаштування лейблу який відображає суму товарів замовлення
    private func createSummLabel() {
        summCoastLabel.textAlignment = .center
        summCoastLabel.font = .systemFont(ofSize: 18)
        summCoastLabel.textColor = .black
        summCoastLabel.text = "\(totalCoast) грн"
        summCoastLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Метод для налаштування лейблу який відображає суму товарів замовлення зі знижкою
    private func createSaleSummLabel() {
        saleSummCoastLabel.textAlignment = .center
        saleSummCoastLabel.font = .systemFont(ofSize: 18)
        saleSummCoastLabel.textColor = .bwtcOragge
        saleSummCoastLabel.text = "\(saleTotalCoast) грн"
        saleSummCoastLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Метод для налаштування кнопки для замовлення товарів
    private func createOrderButton() {
        orderButton.setTitle("Замовити", for: .normal)
        orderButton.setTitleColor(.bwtcLightGrey, for: .normal)
        orderButton.backgroundColor = .bwtcOragge
        orderButton.tintColor = .bwtcOragge
        orderButton.layer.cornerRadius = 12
        orderButton.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
    }
   
    //MARK: - Метод для налаштування лейблу "Сума:"
    private func createSummLabelText() {
        summLabelText.textAlignment = .center
        summLabelText.font = .systemFont(ofSize: 18)
        summLabelText.text = "Сума:"
        summLabelText.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Метод для створення та налаштування констрейнтів об'єктів екрана
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
    
    //MARK: - Метод для оновлення значення в об'єктах saleTotalCoast та totalCoast після змін у таблиці
    private func updateTotalCost() {
        saleTotalCoast = basketViewModel.calculateSaleTotalCost()
        totalCoast = basketViewModel.calculateTotalCost()
        summCoastLabel.text = "\(totalCoast) грн"
        saleSummCoastLabel.text = "\(saleTotalCoast) грн"
        
        }
    
    //MARK: - Метод для оновлення тексту та закреслення тексту у saleSummCoastLabel після змін у таблиці
    private func updateText() {
        if totalCoast == saleTotalCoast {
            saleSummCoastLabel.text = ""
            summCoastLabel.removeUnderline()
           
        } else {
            summCoastLabel.addUnderline()
         
        }
    }
    
    //MARK: - Метод який спрацьовує коли користувач гатистув на кнопку Замовити
    @objc func orderButtonAction() {
        let viewController = AuthorizationViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
   
}

//MARK: - Методи Delegate та DataSource для налаштуваня тадлиці
extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
 
    //MARK:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketViewModel.positions.count
    }
    
    //MARK:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as? BasketTableViewCell {
            cell.position = basketViewModel.positions[indexPath.item]
            totalCoast = basketViewModel.positions.reduce(0) { $0 + $1.basketPrice * $1.stepper }
            summCoastLabel.text = "\(totalCoast) грн"
            saleSummCoastLabel.text = "\(saleTotalCoast) грн"
            updateTotalCost()
            updateText()
            cell.delegate = self
           // myTableView.reloadData()
            return cell
        }
            return UITableViewCell()
            
        }
    
    //MARK:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Опціонально, реагуємо на вибір ячейки
        print("Ви вибрали рядок \(indexPath.row)")
    }
    
    //MARK:
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            basketViewModel.removePosition(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            updateTotalCost()
            tableView.reloadData()
        }
    }
    
    
}

//MARK: -
extension BasketViewController: BasketTableViewCellDelegate {
    func didStepperValueChanged(_ cell: BasketTableViewCell, coast: Int, step: Int, label: UILabel) {
        guard let index = myTableView.indexPath(for: cell) else { return }
        basketViewModel.positions[index.row].stepper = step
        basketViewModel.positions[index.row].basketCoast = coast
        updateTotalCost()
        summCoastLabel.text = "\(totalCoast) грн"
        myTableView.reloadData()
        BasketModel.save(basketViewModel.positions)
       
    }
}

//MARK: -
extension BasketViewController: UIPickerViewDelegate {
    
}
    




//
//  PaymentDeliveryViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 15.02.2024.
//

import UIKit

class PaymentDeliveryViewController: UIViewController {
    
    let paymentTextView = UITextView()
    let imagePaymentView = UIImageView()
    let scrolPaymentView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        view.addSubview(scrolPaymentView)
        scrolPaymentView.addSubview(paymentTextView)
        scrolPaymentView.addSubview(imagePaymentView)
        view.backgroundColor = .white
        createToScrollView()
        createPaymentTextView()
        createImagePaymentView()
        makeConstraints()
    }
    
    func createToScrollView() {
        scrolPaymentView.showsVerticalScrollIndicator = true
        scrolPaymentView.showsHorizontalScrollIndicator = false
        scrolPaymentView.translatesAutoresizingMaskIntoConstraints = false
        scrolPaymentView.alwaysBounceVertical = true
  }
    
    private func createImagePaymentView() {
        imagePaymentView.translatesAutoresizingMaskIntoConstraints = false
        imagePaymentView.image = UIImage(named: "oplata_i_dostavka_empire")
    }

    private func createPaymentTextView() {
        paymentTextView.translatesAutoresizingMaskIntoConstraints = false
        paymentTextView.isEditable = false
        paymentTextView.isScrollEnabled = false
        paymentTextView.text = "Оплата: \nОплата здійснюється на сайті за допомогою сервісу оплати Portmone. Розрахуватись можна Вашою платіжною картою Visa або Mastercard. Також можливий розрахунок післяплатою на Новій пошті.\n\nДоставка: \nВаші замовлення Ви можете отримати замовивши доставку на відділення Нової пошти або забрати самовивозом за адресою: м. Київ, вул. Бульварно-Кудрявська 14 (кавʼярня bwtc) \n\nЗамовлення відправляються з понеділка по пʼятницю на наступний робочий день після оформлення (сб-нд вихідні) \n\nДоставка замовлень від 1500 грн по Києву та Україні на відділення Нової Пошти  - безкоштовно \n\nДоставка замовлень до 1500 грн та курʼєрська доставка по Києву та Україні сплачується отримувачем за тарифами Нової Пошти \n\nДоставка замовлень за оптовим прайсом сплачується отримувачем за тарифами Нової Пошти. \n\nПовернення: \nПовернення можливе протягом 14 днів після відвантаження (відправлення) товару за умови збереження товарного вигляду та наявності чека про покупку \n\nПоверненню не підлягають продукти харчування (кава та чай) "
        rangesText(textToRanges: paymentTextView.text)
        paymentTextView.textAlignment = .center
        paymentTextView.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func attributedText(text: String, ranges: [String]) {
        let attributed = NSMutableAttributedString(string: text)
        for rangeString in ranges {
            let range = (text as NSString).range(of: rangeString)
            attributed.addAttribute(.foregroundColor, value: UIColor.mainOragge, range: range)
            attributed.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 19), range: range)
        }
        paymentTextView.attributedText = attributed
        
    }
    
    private func rangesText(textToRanges: String) {
        let ranges = ["Оплата:","Доставка:", "Повернення:"]
        attributedText(text: textToRanges, ranges: ranges)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            scrolPaymentView.topAnchor.constraint(equalTo: view.topAnchor),
            scrolPaymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrolPaymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrolPaymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imagePaymentView.topAnchor.constraint(equalTo: scrolPaymentView.topAnchor,constant: 20),
            imagePaymentView.centerXAnchor.constraint(equalTo: scrolPaymentView.centerXAnchor),
            imagePaymentView.widthAnchor.constraint(equalTo: scrolPaymentView.widthAnchor, multiplier: 0.7),
            imagePaymentView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.32),
            
            paymentTextView.topAnchor.constraint(equalTo: imagePaymentView.bottomAnchor,constant: 20),
            paymentTextView.bottomAnchor.constraint(equalTo: scrolPaymentView.bottomAnchor),
            paymentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            paymentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
    }
    
}

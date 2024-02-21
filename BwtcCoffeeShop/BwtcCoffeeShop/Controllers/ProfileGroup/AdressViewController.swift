//
//  AdressViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.02.2024.
//

import UIKit

class AdressViewController: UIViewController {
    
    
    let adressTextView = UITextView()
    let adressScrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupView()
    }
    
    private func setupView() {
        view.addSubview(adressScrollView)
        adressScrollView.addSubview(adressTextView)
    }

    
    func createAdressScrollView() {
        adressScrollView.showsVerticalScrollIndicator = true
        adressScrollView.showsHorizontalScrollIndicator = false
        adressScrollView.translatesAutoresizingMaskIntoConstraints = false
        adressScrollView.alwaysBounceVertical = true
  }
    
   

    private func createAdressTextView() {
        adressTextView.translatesAutoresizingMaskIntoConstraints = false
        adressTextView.isEditable = false
        adressTextView.isScrollEnabled = false
        adressTextView.text = ""
       
        adressTextView.textAlignment = .center
        adressTextView.font = UIFont.systemFont(ofSize: 17)
    }
   
}

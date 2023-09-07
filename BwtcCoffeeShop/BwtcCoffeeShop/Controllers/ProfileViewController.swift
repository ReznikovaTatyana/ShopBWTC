//
//  ProfileViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let imageView = UIImageView()
    let image = UIImage(named: "Ethiopia Guji")
    let imageUrl: String = "https://static.wixstatic.com/media/6159d6_7a97d8f91e20495bbd44d528b9671542~mv2.png/v1/fill/w_964,h_964,al_c,usm_0.66_1.00_0.01/6159d6_7a97d8f91e20495bbd44d528b9671542~mv2.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        view.backgroundColor = .white
        setupViews()
        createConstr()
        config(path: imageUrl)
 }
    
    func config(path: String) {
        if let url = URL(string: path),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            imageView.image = image
        }
    }

    private func setupViews() {
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
        view.addSubview(imageView)
    }
    
    func createConstr() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(200)
            make.left.equalTo(30)
            make.top.equalTo(30)
        }
    }
    
}


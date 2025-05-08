//
//  HomeImageCell.swift
//  BwtcCoffeeShop
//
//  Created by mac on 08.05.2023.
//

import UIKit
import MapKit

class HomeImage: UICollectionViewCell, HomeImageProtocol {
    let homeImage = UIImageView()
    let identifaer = "ImageCell"
    var seriesImages:[String] = ["IMG_8454", "IMG_8462"]
    let imagePageControl = UIPageControl()
    
    let verticalSpacing: CGFloat = 5
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
       createImage()
        createImagePageControl()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
    }
    
    
    func createImage() {
        self.contentView.addSubview(homeImage)
        homeImage.translatesAutoresizingMaskIntoConstraints = false
        homeImage.contentMode = .scaleAspectFit
        homeImage.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            homeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            homeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            homeImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            homeImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            
            homeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
    }
    
    func configureCell(imageName: String) {
        homeImage.image = UIImage(named: imageName)
    }
    
    func createImagePageControl() {
        self.contentView.addSubview(imagePageControl)
        imagePageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            imagePageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imagePageControl.bottomAnchor.constraint(equalTo: homeImage.bottomAnchor, constant: 1),
            imagePageControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePageControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        imagePageControl.numberOfPages = seriesImages.count
        imagePageControl.pageIndicatorTintColor = .bwtcGrey
        imagePageControl.currentPage = seriesImages.count
        imagePageControl.currentPageIndicatorTintColor = .bwtcOragge
        //imagePageControl.backgroundStyle = .automatic
        imagePageControl.addTarget(self, action: #selector(pageDidChange(_sende: )), for: .valueChanged)
    }
    
    
    @objc func pageDidChange(_sende: UIPageControl) {
        _ = UIScreen.main.bounds.width * CGFloat(imagePageControl.currentPage)
    }
    
}




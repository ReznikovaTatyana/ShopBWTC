//
//  FirstScreenViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit

protocol HomeImageProtocol {
    var seriesImages: [String] { get }
}

protocol PopularProductsProtocol {
    var popularProductsArray: [Goods] { get }
}

protocol CoffeeDetailProtocol {
    
}

// MARK: Клас для першого екрану додатка, який відображає зображення та популярні товари
class FirstScreenViewController: UIViewController {
    
    // MARK: Об'єкт для керування сторінками зображень
    let imagePageControl = UIPageControl()
   
    // MARK: Колекція для відображення горизонтальної каруселі зображень
    var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            imageCollectionView.backgroundView = .none
            imageCollectionView.bounces = false
            imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
                layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        return imageCollectionView
        }()
    
    
    //MARK: Колекція для відображення вертикального списку популярних товарів
    var popularProductsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let productsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            productsCollectionView.translatesAutoresizingMaskIntoConstraints = false
            layout.scrollDirection = .vertical
            layout.headerReferenceSize = .init(width: 250, height: 20)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
        return productsCollectionView
        }()
    
    //MARK: Об'єкт для управління зображеннями на головному екрані
    var homeImage: HomeImageProtocol = HomeViewModel()
    
    // MARK: Об'єкт для управління популярними товарами на головному екрані
    var popularProductsViewModel = PopularProductsViewModel()
   
    var detailViewController = CoffeeDetailViewController()
    
    //MARK: Масив секцій з популярними товарами
    lazy var section: [SectionCoffee] = [
        SectionCoffee(sectionName: "Популярні товари", coffee: popularProductsViewModel.popularProductsArray)]
    
    
    let stackView = UIStackView()
          
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    //MARK: Налаштовує елементи інтерфейсу
    private func setupViews() {
        addFirebase()
        createCustomNavigationBar()
        createSearch()
        setupStackView()
        setupImageCollectionView()
        setupProductsCollectionView()
        setupNavigationItems()
    }
    
    //MARK: Налаштовує елементи навігації
    private func setupNavigationItems() {
        let logoImageItem = createCustomTitleView()
        navigationItem.titleView = logoImageItem
    }
    
    //MARK: Оновлює дані товарів з Firebase для розділу популярних продуктів та перезавантажує колекцію.
    private func addFirebase() {
        popularProductsViewModel.updateGoodsFromFirebasePopularPack { [weak self] in
            self?.popularProductsCollectionView.reloadData()
        }
    }
    
    //MARK:  Створює та налаштовує StackView
    private func setupStackView() {
            view.addSubview(stackView)
            stackView.axis = .vertical
            stackView.spacing = 0
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
 
   
    //MARK: Створює та налаштовує колекцію для відображення горизонтальної каруселі зображень
    func setupImageCollectionView() {
        stackView.addArrangedSubview(imageCollectionView)
        //view.addSubview(imageCollectionView)
        imageCollectionView.register(HomeImage.self, forCellWithReuseIdentifier: "HomeImage")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        makeConstraints(to: imageCollectionView)
        imageCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    }

    
    //MARK: Створює та налаштовує колекцію для відображення вертикального списку популярних товарів
    func setupProductsCollectionView() {
        stackView.addArrangedSubview(popularProductsCollectionView)
        //self.view.addSubview(popularProductsCollectionView)
        popularProductsCollectionView.dataSource = self
        popularProductsCollectionView.delegate = self
        popularProductsCollectionView.register(PopularProductsCell.self, forCellWithReuseIdentifier: "PopularProductsCell")
        popularProductsCollectionView.register(HomeHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeHeaderCollectionReusableView")
        
       makeConstraints(to: popularProductsCollectionView)
        popularProductsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    
   //MARK: Встановлення загальних констрейнтів для обох колекцій
    func makeConstraints(to collectionView: UICollectionView) {
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    //MARK: Налаштування
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        imagePageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
//
//    }
    
}


extension FirstScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
        return homeImage.seriesImages.count
        } else {
            return popularProductsViewModel.popularProductsArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeImage", for: indexPath) as? HomeImage {
            cell.homeImage.image = UIImage(named: homeImage.seriesImages[indexPath.item])
            return cell
        }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularProductsCell", for: indexPath) as? PopularProductsCell {
                cell.products = popularProductsViewModel.popularProductsArray[indexPath.item]
                return cell
            }
        }
        return UICollectionViewCell()
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        if  collectionView == popularProductsCollectionView {
            let menu =  PopularProductsCell()
            menu.products = popularProductsViewModel.popularProductsArray[indexPath.item]
            detailViewController.coffeeGoods = menu.products
            detailViewController.labelName.text = menu.nameProducts.text
            detailViewController.imageView.image = menu.imageProducts.image
            detailViewController.labelPrice.text = menu.priceProducts.text
            detailViewController.textLabel.text = menu.text.text
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderCollectionReusableView", for: indexPath) as? HomeHeaderCollectionReusableView {
                    return headerView
                }
            }
            return UICollectionReusableView()
        }
}

extension FirstScreenViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == imageCollectionView {
                    let screenWidth = collectionView.bounds.width
                    let screenHeight = collectionView.bounds.height
                    return CGSize(width: screenWidth, height: screenHeight)
                } else {
                    let productsCV = popularProductsCollectionView
                    let screenWidth = productsCV.frame.width
                    let screenHeight = productsCV.bounds.height
                    let cellWidth = screenWidth * 0.33
                    let cellHeight = screenHeight  * 0.33
                    return CGSize(width: cellWidth, height: cellHeight)
                }
    }
}



    

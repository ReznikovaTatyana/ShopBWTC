//
//  ProfileViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var profileTableView: UITableView = {
        let table = UITableView()
       table.rowHeight = 110
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        return table
    }()
    
    var profileArray: ProfileModelProtocol = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        view.addSubview(profileTableView)
        view.backgroundColor = .white
        profileTableView.delegate = self
        profileTableView.dataSource = self
        setupViews()
       
 }

    private func setupViews() {
        let segmentLanguageItem = customSegment()
        let logoImageItem = createCustomTitleView()
        navigationItem.rightBarButtonItem = segmentLanguageItem
        navigationItem.titleView = logoImageItem
        makeConstraints()
        
    }
    
    func makeConstraints() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }

    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileArray.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell {
           
            let info = profileArray.info[indexPath.item]
            cell.configure(with: info)
            return cell
        }
            return UITableViewCell()
            
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProfile = profileArray.info[indexPath.item]
        navigateToProfile(selectedProfile)
    }
    
    
    private func navigateToProfile(_ profile: ProfileModel) {
        let viewController = ProfileViewControllerFactory.createViewController(for: profile)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
   
    
    
}




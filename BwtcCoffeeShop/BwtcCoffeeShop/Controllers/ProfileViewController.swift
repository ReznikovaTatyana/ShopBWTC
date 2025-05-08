//
//  ProfileViewController.swift
//  BwtcCoffeeShop
//
//  Created by mac on 20.04.2023.
//

import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    var personTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 110
        table.register(PersonTableViewCell.self, forCellReuseIdentifier: "PersonTableViewCell")
        return table
    }()
    
    var profileTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 110
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        
        return table
    }()
    
    let singOutButton = UIButton()
    
    var profileArray: ProfileModelProtocol = ProfileViewModel()
    var personViewModel: PersonViewModel = PersonViewModel()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personViewModel.fetchUserData(table: personTableView)
        personTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        view.addSubview(personTableView)
        view.addSubview(profileTableView)
        view.addSubview(singOutButton)
        view.backgroundColor = .white
        personTableView.delegate = self
        personTableView.dataSource = self
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
        createSingOutButton()
        
    }
    
    private func createSingOutButton() {
        singOutButton.translatesAutoresizingMaskIntoConstraints = false
        singOutButton.addTarget(self, action: #selector(singOutButtonAction), for: .touchUpInside)
        singOutButton.setTitle("Вийти", for: .normal)
        singOutButton.setTitleColor(.bwtcLightGrey, for: .normal)
        singOutButton.backgroundColor = .bwtcOragge
        singOutButton.tintColor = .bwtcOragge
        singOutButton.layer.cornerRadius = 10
        view.addSubview(singOutButton)
    }
    
    
    func makeConstraints() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        personTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personTableView.topAnchor.constraint(equalTo: view.topAnchor),
            personTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            personTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            personTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            personTableView.heightAnchor.constraint(equalToConstant: 200),
            
            profileTableView.topAnchor.constraint(equalTo: personTableView.bottomAnchor),
            
            profileTableView.bottomAnchor.constraint(equalTo: singOutButton.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            //singOutButton.topAnchor.constraint(equalTo: profileTableView.bottomAnchor, constant: 10),
            singOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            singOutButton.heightAnchor.constraint(equalToConstant: 40),
            singOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            singOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
        ])
    }
    
//MARK: -
    
  
    

//MARK: -
    @objc func singOutButtonAction() {
        personViewModel.singOutUser()
        personTableView.reloadData()
    }
    
}
    

    


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == personTableView {
            return personViewModel.person.count
            } else if tableView == profileTableView {
                return profileArray.info.count
            }
            return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == personTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell {
                let person = personViewModel.person[indexPath.row]
                cell.imagePersonCell.image = UIImage(systemName: person.image)
               // cell.personLabelCell.text = person.label
                if personViewModel.currentUser != nil {
                    cell.personLabelCell.text = (personViewModel.currentUser?.firstName ?? "") + " " + (personViewModel.currentUser?.lastName ?? "")
                } else if personViewModel.currentUser == nil {
                    cell.personLabelCell.text = "Увійти"
                    
                }
                return cell
            }
        } else if tableView == profileTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell {
                
                let info = profileArray.info[indexPath.row]
                cell.configure(with: info)
                return cell
            }
        }
            return UITableViewCell()
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == profileTableView {
            let selectedProfile = profileArray.info[indexPath.row]
            navigateToProfile(selectedProfile)
        }
        if tableView == personTableView {
            if personViewModel.currentUser != nil {
                let personVC = PersonViewController()
                personVC.delegate = self
                navigationController?.pushViewController(personVC, animated: true)
            } else if personViewModel.currentUser == nil {
                let authorizationVC = AuthorizationViewController()
                navigationController?.pushViewController(authorizationVC, animated: true)
            }
            
       }
    }
    
    
    private func navigateToProfile(_ profile: ProfileModel) {
        let viewController = ProfileViewControllerFactory.createViewController(for: profile)
        navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
    private func navigateToPerson(person: ProfileModel) {
        let vc = PersonViewControllerFactory.personViewController(person: person)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController: PersonViewControllerDelegate {
    func changeLable() {
        personViewModel.currentUser = nil
        personTableView.reloadData()
    }
}

//
//  ProfileViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/9/21.
//

import UIKit


//This is the navigation pane at the bottom of the app screen
class ProfileViewController: UIViewController {
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Profile"
        self.tabBarItem.image = UIImage(named: "profile_icon")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addTitle()
        addSignoutButton()
    }
    
    
    func addTitle() {
        let title = UILabel()
        title.text = "Profile"
        title.textAlignment = .center
        title.textColor = .systemOrange
        title.font = .boldSystemFont(ofSize: 35)
        
        view.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17).isActive = true
        title.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17).isActive = true
        title.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    func addSignoutButton() {
        
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(self, action: #selector(signoutPressed), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -110).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    @objc
    func signoutPressed(sender : UIButton) {
        UserDefaults.standard.setIsLoggedIn(value: false)
        perform(#selector(showWelcomeViewController), with: nil, afterDelay: 0.01)
    }
    
    @objc
    func showWelcomeViewController() {
        let mainNavigationController = MainNavigationController()
        let welcomeViewController = WelcomeViewController()
        mainNavigationController.modalPresentationStyle = .fullScreen
        mainNavigationController.navigationBar.barTintColor = .systemOrange
        mainNavigationController.viewControllers = [welcomeViewController]
                
        present(mainNavigationController, animated: true, completion: nil)
    }
}

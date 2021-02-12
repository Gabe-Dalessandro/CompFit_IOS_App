//
//  MainTabBarController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/5/21.
//

import Foundation
import UIKit


//This is the navigation pane at the bottom of the app screen
class MainTabBarController: UITabBarController {
    
    func loadControllers() {
        let dashboardVC = DashboardViewController()
        let socialFeedVC = SocialFeedViewController()
        let addVC = AddViewController()
        let challengesVC = ChallengesViewController()
        let profileVC = ProfileViewController()
        
        
        self.viewControllers = [dashboardVC, socialFeedVC, addVC, challengesVC, profileVC]
    }
    
    
    //loads the titles in the tab bar so it will be shown in load
    override func viewWillAppear(_ animated: Bool) {
        loadControllers()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor(red: 255.0/255.0, green: 106.0/255.0, blue: 0.01, alpha: 1)
//        addSignoutButton()
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

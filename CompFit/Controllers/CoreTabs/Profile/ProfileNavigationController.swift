//
//  ProfileNavigationController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/12/21.
//

import UIKit


//Allows naviagation buttons at the top of the screen
class ProfileNavigationController: UINavigationController {
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Profile"
        self.tabBarItem.image = UIImage(named: "profile_icon")
        
        let profileVC = ProfileViewController()
        self.pushViewController(profileVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = Constants.Colors.brandBlue
        view.backgroundColor = .red
    }
}

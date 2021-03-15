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
        let dashboardVC = DashboardNavigationController()
        let socialFeedVC = FeedNavigationController()
        let addVC = AddViewController()
        let exploreVC = ExploreNavigationController()
        let profileVC = ProfileNavigationController()
        
        self.viewControllers = [profileVC, exploreVC, dashboardVC, socialFeedVC, addVC]
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
    }

}

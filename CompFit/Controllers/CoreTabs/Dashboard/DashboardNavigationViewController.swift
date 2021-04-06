//
//  DashboardNavViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/10/21.
//

import UIKit



//Allows naviagation buttons at the top of the screen
class DashboardNavigationController: UINavigationController {
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Dashboard"
        self.tabBarItem.image = UIImage(named: "dashboard_icon")
        
        let dashboardVC = DashboardViewController()
        self.pushViewController(dashboardVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = .white

    }
}

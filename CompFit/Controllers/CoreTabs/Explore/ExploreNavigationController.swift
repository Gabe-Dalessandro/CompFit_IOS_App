//
//  ExploreNavigationController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/14/21.
//

import UIKit

class ExploreNavigationController: UINavigationController {

    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Explore"
        self.tabBarItem.image = UIImage(named: "explore_icon")
        
        let exploreVC = ExploreViewController()
        self.pushViewController(exploreVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = Constants.deepOrange
        view.backgroundColor = .red
    }

}
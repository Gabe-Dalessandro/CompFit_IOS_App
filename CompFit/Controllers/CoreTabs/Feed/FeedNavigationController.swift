//
//  FeedViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/9/21.
//

import UIKit


//This is the navigation pane at the bottom of the app screen
class FeedNavigationController: UINavigationController {
    

    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Feed"
        self.tabBarItem.image = UIImage(named: "social_icon")
        
        let feedVC = FeedViewController()
        self.pushViewController(feedVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = Constants.deepOrange
        view.backgroundColor = .white
        
    }
}

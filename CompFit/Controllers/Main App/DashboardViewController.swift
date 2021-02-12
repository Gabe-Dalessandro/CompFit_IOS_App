//
//  DashboardViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/9/21.
//

import UIKit


//This is the navigation pane at the bottom of the app screen
class DashboardViewController: UIViewController {
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Dashboard"
        self.tabBarItem.image = UIImage(named: "dashboard_icon")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addTitle()
    }
    
    
    func addTitle() {
        let title = UILabel()
        title.text = "Dashboard"
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
}

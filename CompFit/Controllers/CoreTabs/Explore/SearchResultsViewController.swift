//
//  SearchResultsViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 4/1/21.
//

import UIKit

// Created a delegate becasue when we tap on the results, we dont want to push the controller onto the search controller, we want to push it onto the Discover controller
protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewController(vc: SearchResultsViewController, didSelectResultsWith user: UserModel)
}


class SearchResultsViewController: UIViewController {

    public weak var delegate: SearchResultsViewControllerDelegate?
    private var users = [UserModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .onDrag
        
    }
    
    public func update(with results: [UserModel]) {
        self.users = results
        tableView.reloadData()
        
        // Shows table view if query was not empty
        if !users.isEmpty {
            tableView.isHidden = false
        }
    }
    
}







// Search Results will have 5 different Sections
    // 0) Users
    // 1) Workouts
    // 2) Prememium Trainers
    // 3) Featured Content/Trainers
    // 4) Upcoming Classes

    // 5) All Users
    // 6) All Workouts
    // 7) All Featured Content
    // 8) All Classes
    // 9) All Routines
    // 10) All Trainers
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Sections: Number of sections in the Search Results
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // Items: Number of items in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users.count > 5 {
            return 5
        }
        return users.count
    }
    
    // Height for Items
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Height is only different for the Featured Content
        if indexPath.section == 2 {
            return 50.0
        }
        return 20.0
    }
    

    
    // Headers: what header to use for each section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let label = UILabel()
            label.text = "   Users   "
            label.textAlignment = .left
            label.font = UIFont.poppinsMedium(size: 24)
            label.textColor = .white
            label.backgroundColor = Constants.Colors.brandLightGrey
            return label
        }
        else if section == 1 {
            let label = UILabel()
            label.text = "   Workouts  "
            label.textAlignment = .left
            label.font = UIFont.poppinsMedium(size: 24)
            label.textColor = .white
            label.backgroundColor = Constants.Colors.brandLightGrey
            return label
        }
        else if section == 2 {
            let label = UILabel()
            label.text = "   Featured  "
            label.textAlignment = .left
            label.font = UIFont.poppinsMedium(size: 24)
            label.textColor = .white
            label.backgroundColor = Constants.Colors.brandLightGrey
            return label
        }

        return nil
    }
    
    // Height for Headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 2 {
            return 0
        }
        return 28
    }
    
    
    // Cells that will be used
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Top Results for that Section
        // 0. Users
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = users[indexPath.row].email
            return cell
        }
        // 1. Workouts
        else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = users[indexPath.row].email
            return cell
        }
        // 2. Featured Content
        else if (indexPath.section == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = users[indexPath.row].email
            return cell
        }


        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].email
        return cell
        
        
        // See all results of that section
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchResultsViewController(vc: self, didSelectResultsWith: users[indexPath.row])
    }
    
}



//
//  ListViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/10/21.
//

import UIKit


//Will simply list data vertically within this controller using a tableView
    // Will pass in the data you want it to show
class ListViewController: UIViewController {

    private let data: [UserRelationship]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identitifer)
        return tableView
    }()
    
    //Pass in the data you want it to display
    init(dataToDisplay: [UserRelationship]) {
        self.data = dataToDisplay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    

}





extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identitifer, for: indexPath) as! UserFollowTableViewCell
        listCell.configure(relationshipModel: data[indexPath.row])

        listCell.delegate = self
        return listCell
    }
    

    //When selecting that row, will go to the user's profile
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.row]
    }
    
    //Gives the cell a height when its used
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserFollowTableViewCell.cellHeight
    }
    
}



extension ListViewController: UserFollowTableViewCellDelegate {
    func didTapFollowUnfollowButton(relationshipModel: UserRelationship) {
        switch relationshipModel.type {
        case .following:
            //perform http request to follow this user
            break
        case .not_following:
            //perform http request to unfollow this user
            break
        }
    }
}

//
//  NotificationsViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/8/21.
//

import UIKit



//Shows a list of notifications that have occured
    //Notification Types that a user will see:
    //1. Likes: who liked what post
    //2. Follows: who followed the user
class NotificationsViewController: UIViewController {

    //Mock Notifications
    private var mockModels = [UserNotification]()
    
    
    //Set the table view hidden = true to start: we will have to fetch the notifications so it will be blank at first
    private let notificationsTableView: UITableView = {
        let tableView = UITableView()
//        tableView.isHidden = true
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    //Lazy: will only instantiate this when we need it: ie, when there are no notifications to display
    private lazy var noNotificationsView = NoNotificationsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications"
        self.view.backgroundColor = .systemBackground
        //Add the loading spinner: spins while we fetch data
        view.addSubview(spinner)
//        spinner.startAnimating()
        
        getNotifications()
        
        //Add the table view for the notifications
        view.addSubview(notificationsTableView)
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notificationsTableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    
    private func getNotifications() {
        for i in 0...100{
            let user = UserModel(email: "gdalessa",
                                 password: "fitness123",
                                 phoneNumber: "5707936087",
                                 birthday: "1943-09-19",
                                 totalPoints: 0,
                                 gender: "Female",
                                 fitnessExp: "Beginner",
                                 workoutIntensity: "High",
                                 workoutTypes: ["HIIT"])
            
            let post = UserPost(identifier: "",
                                owner: user,
                                postType: .photo,
                                thumbnailImage: URL(string: "https://www.google.com/")!,
                                postURL: URL(string: "https://www.google.com/")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                dateCreated: Date(),
                                taggedUsers: [])
            
            let model = UserNotification(type: i%2 == 0 ? .like(post: post) : .follow(state: .not_following), text: "hello world", user: user)
            
            mockModels.append(model)
        }
    }
    
    
    //Displays the "No Notifications View" if the user has 0 notifications
    private func addNoNotificationsView() {
        notificationsTableView.isHidden = true
        self.view.addSubview(noNotificationsView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.width/4)
        noNotificationsView.center = view.center
    }
    
    
    
}



extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockModels.count
    }
    
    //Dequeues cells that will be used in the table view
    //must remeber to also set the cells delegate when it is dequeued
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = mockModels[indexPath.row]
        
        //Determine which type of notification this is: like or follow
        switch model.type {
        case .like(_):
            //like cell
            let likeCell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            
            likeCell.configure(with: model)
            likeCell.delegate = self
            return likeCell
        case .follow:
            //follow cell
            let followCell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            
//            followCell.configure(with: model)
            followCell.delegate = self
            return followCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NotificationLikeEventTableViewCell.cellHeight
    }
    
}




extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        print("Tapped Post")
        //Open post when user taps post
        switch model.type {
        case .like(let post):
            let postVC = PostViewController(model: post)
            self.navigationController?.pushViewController(postVC, animated: true)
        case .follow(_):
            fatalError("Dev Issue: Should never get called")
        }
        
        
    }
}


extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("tapped unfollow button")
        //Perform database update
    }
    
}

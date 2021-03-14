//
//  FeedController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/7/21.
//

import UIKit

struct FeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}


class FeedViewController: UIViewController {
    
    //Made of 4 sections: structure is described above
    private var feedRenderModels = [FeedRenderViewModel]()
    private var numSectionsInFeedModel = 4
    
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        
        // Register cells to the tableview
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        tableView.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        tableView.register(FeedPostActionsTableViewCell.self, forCellReuseIdentifier: FeedPostActionsTableViewCell.identifier)
        tableView.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Feed"
        self.navigationItem.title = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //Add the table view
        view.addSubview(feedTableView)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        createMockPosts()
    }
    
    
    
    private func createMockPosts() {
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
        
        var commentsArr = [PostComment]()
        for i in 0..<2 {
            let newComment = PostComment(identifier: "123_\(i)",
                                         username: "@jenny",
                                         text: "This is the best post I've seen!!!",
                                         dateCreated: Date(),
                                         likes: []
            )
            commentsArr.append(newComment)
        }

        
        for x in 0..<5 {
            let header = PostRenderViewModel(renderType: .header(provider: user))
            let content = PostRenderViewModel(renderType: .primaryContent(provider: post))
            let actions = PostRenderViewModel(renderType: .actions(provider: ""))
            let commentss = PostRenderViewModel(renderType: .comments(comments: commentsArr))
            
            let viewModel = FeedRenderViewModel(header: header,
                                                post: content,
                                                actions: actions,
                                                comments: commentss)
            feedRenderModels.append(viewModel)
        }
    }
    
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        feedTableView.frame = view.bounds
    }
    
    
    func addTitle() {
        let title = UILabel()
        title.text = "Feed"
        title.textAlignment = .center
        title.textColor = .systemRed
        title.font = .boldSystemFont(ofSize: 35)
        
        view.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 17).isActive = true
        title.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17).isActive = true
        title.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
}







extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    //Each Post Render has 4 sections so we need the number of post renders * 4
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * numSectionsInFeedModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let postModel: FeedRenderViewModel
        
        //if we are going to display the first model
        if section == 0 {
            postModel = feedRenderModels[0]
            
        } else {
            //Logic to find which model we are currently at
            let position = section % numSectionsInFeedModel == 0 ? section/numSectionsInFeedModel: ((section - (section%numSectionsInFeedModel)) / numSectionsInFeedModel)
            postModel = feedRenderModels[position]
        }
        
        //Display the cell based on the section we are in
        let currentPost = section % numSectionsInFeedModel
        
        // Header
        if currentPost == 0 {
            return 1
        }
        // Post
        else if currentPost == 1 {
            return 1
        }
        // Actions
        else if currentPost == 2 {
            return 1
        }
        // Comments
        else if currentPost == 3 {
            let commentsModel = postModel.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2: comments.count
            default: fatalError("Invalid case for comments")
            }
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Use section since our cells are broken out by section
        let section = indexPath.section
        let postModel: FeedRenderViewModel
        
        //if we are going to display the first model
        if section == 0 {
            postModel = feedRenderModels[0]
            
        } else {
            //Logic to find which model we are currently at
            let position = section % numSectionsInFeedModel == 0 ? section/numSectionsInFeedModel: ((section - (section%numSectionsInFeedModel)) / numSectionsInFeedModel)
            postModel = feedRenderModels[position]
        }
        
        //Display the cell based on the section we are in
        let currentPost = section % numSectionsInFeedModel
        
        // Header
        if currentPost == 0 {
            let headerModel = postModel.header
            switch headerModel.renderType {
            case .header(let user):
                let headerCell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier, for: indexPath) as! FeedPostHeaderTableViewCell
                headerCell.configure(with: user)
                headerCell.delegate = self
                return headerCell
            default: fatalError()
            }

        }
        // Post
        else if currentPost == 1 {
            let postContentModel = postModel.post
            switch postContentModel.renderType {
            case .primaryContent(let post):
                let contentCell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier, for: indexPath) as! FeedPostTableViewCell
                contentCell.configure(with: post)
                return contentCell
            default: fatalError()
            }
        }
        // Actions
        else if currentPost == 2 {
            let actionModel = postModel.actions
            
            switch actionModel.renderType {
            case .actions(let provider):
                let actionsCell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifier, for: indexPath) as! FeedPostActionsTableViewCell
                actionsCell.delegate = self
                return actionsCell
            default: fatalError()
            }
            
        }
        // Comments
        else if currentPost == 3 {
            let commentModel = postModel.comments
            
            switch commentModel.renderType {
            case .comments(_):
                let commentCell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifier, for: indexPath) as! FeedPostGeneralTableViewCell
                return commentCell
            default: fatalError("Invalid case for comments in post model")
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Determines how tall the cell should be when its displayed
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentPostSection = indexPath.section%numSectionsInFeedModel
        
        // Header
        if currentPostSection == 0 {
            return FeedPostHeaderTableViewCell.cellHeight
        }
        // Post
        else if currentPostSection == 1 {
            return FeedPostTableViewCell.cellHeight(tableView: tableView)
        }
        // Actions
        else if currentPostSection == 2 {
            return FeedPostActionsTableViewCell.cellHeight
        }
        // Comments
        else if currentPostSection == 3 {
            return FeedPostGeneralTableViewCell.cellHeight
        }
        
        return 0
    }
    
    

    
    //Sets spacing between posts in the feed
    //Does this by adding a footer at the end of each post
    //Creates the footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    //Sets the size after every post section (which is after the comments which is in index 3 of each post)
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % numSectionsInFeedModel
        return subSection == 3 ? 70 : 0
    }
    
}







/*
 DELEGATES TO HANDLE THE DIFFERENT CELLS
 - header delegate
 - action delegate
 - comments delegate
 */



// Header Cell
    // When user taps "more" button
extension FeedViewController: FeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func reportPost() {
        
    }
}


// Actions Cell
    // When user taps an of the actions within the actions cell
extension FeedViewController: FeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
}

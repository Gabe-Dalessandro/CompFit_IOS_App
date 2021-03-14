//
//  PostViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/9/21.
//

import UIKit

//What the Post should visually look like: broken down into models
/*
 Section: Header model
 Section: Post Cell model
 Section: Action buttons cell model
 Secition: General models
    - n number of general models
 */


//Different types that are part of the post that will be rendered
enum PostRenderType {
    case header(provider: UserModel)
    case primaryContent(provider: UserPost) //the actual post
    case actions(provider: String) //like, comment, share
    case comments(comments: [PostComment])
}


//Model of Rendered Post
struct PostRenderViewModel {
    let renderType: PostRenderType
}



//Handles a post object and all of its data
class PostViewController: UIViewController {
    //The post used to display contents on this screen
    private var postModel: UserPost?
    
    //Made of 4 sections: structure is described above
    private var renderModels = [PostRenderViewModel]()
    
    
    private let postTableView: UITableView = {
        let tableView = UITableView()
        
        // Register cells to the tableview
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        tableView.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        tableView.register(FeedPostActionsTableViewCell.self, forCellReuseIdentifier: FeedPostActionsTableViewCell.identifier)
        tableView.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    
    init(model: UserPost){
        self.postModel = model
        super.init(nibName: nil, bundle: nil)
        
        self.configureTableViewModels()
        self.title = self.postModel?.postType.rawValue
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(postTableView)
        view.backgroundColor = .systemBackground
        
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postTableView.frame = self.view.bounds
    }
    
    //Builds the views we will see:
    //Fills in renderModels array with the sections we want to be displayed on the screen
    private func configureTableViewModels(){
        guard let userPostModel = self.postModel else {
            return
        }
        
        //Header
        let header = PostRenderViewModel(renderType: .header(provider: userPostModel.owner))
        renderModels.append(header)
        
        //Post
        let post = PostRenderViewModel(renderType: .primaryContent(provider: userPostModel))
        renderModels.append(post)

        //Actions
        let actions = PostRenderViewModel(renderType: .actions(provider: ""))
        renderModels.append(actions)
        
        //Comments
        var testCommentObjs = [PostComment]()
        for x in 0...4 {
            let newComment = PostComment(identifier: "123_\(x)",
                                         username: "@dave",
                                         text: "Great post!",
                                         dateCreated: Date(),
                                         likes: []
            )
            testCommentObjs.append(newComment)
        }
        let comments = PostRenderViewModel(renderType: .comments(comments: testCommentObjs))
        renderModels.append(comments)
    }
    
}



//We will use the sections when creating the different areas of the post
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .header(_): return 1
        case .primaryContent(_): return 1
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Use section since our cells are broken out by section
        let model = renderModels[indexPath.section]
        
        //Determine the type of the post that should display
        switch model.renderType {
        //Header area
        case .header(_):
            let headerCell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier, for: indexPath) as! FeedPostHeaderTableViewCell
            return headerCell
            
        //Where the post is displayed
        case .primaryContent(_):
            let contentCell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier, for: indexPath) as! FeedPostTableViewCell
            return contentCell
            
        //Where others can interact with the post (like, tag, or send to other user)
        case .actions(let actions):
            let actionCell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifier, for: indexPath) as! FeedPostActionsTableViewCell
            return actionCell
            
        //Area to see and create comments
        case .comments(let comments):
            let commentCell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifier, for: indexPath) as! FeedPostGeneralTableViewCell
            return commentCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Determines how tall the cell should be when its displayed
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch renderModels[indexPath.section].renderType {
        case .header(_): return FeedPostHeaderTableViewCell.cellHeight
        case .primaryContent(_): return FeedPostTableViewCell.cellHeight(tableView: tableView)
        case .actions(_): return FeedPostActionsTableViewCell.cellHeight
        case .comments(_): return FeedPostGeneralTableViewCell.cellHeight
        }
    }
    
}

//
//  NotificationLikeEventTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/10/21.
//

import UIKit
import SDWebImage

//Used for the controller to know what to do once that followButton is tapped
protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}


//Shows who liked a specific post: Will show a thumbnail of the video or picture that was posted and who liked it
    //Tapping on the post: opens the post up
    //Tapping on the notification: takes you to the users profile
class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    static let cellHeight: CGFloat = 52.0
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    private var notificationModel: UserNotification?
//    private var postModel: UserPost?
    
    //Holds the picture or the video of the post that was liked
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    //Holds the name of the user and the action of following
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        
        label.text = "@joe liked your photo"
        
        return label
    }()
    
    //The button that allows you to either follow the user back or unfollow
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "profile_test_image"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Post Image
        postImageView.frame = CGRect(x: 3, y: 3, width: contentView.frame.height-6, height: contentView.frame.height-6)
        postImageView.layer.cornerRadius = contentView.frame.height/2
        
        //Post Button
        let buttonSize = contentView.frame.height-4
        postButton.frame = CGRect(x: contentView.frame.width - buttonSize - 5, y: 2, width: buttonSize, height: buttonSize)
        
        //Label
        let labelWidth = contentView.frame.width - buttonSize - postImageView.frame.width - 16
        label.frame = CGRect(x: postImageView.frame.maxX + 5,
                             y: 0,
                             width: labelWidth,
                             height: contentView.frame.height)
    }
    
    //Saves the Notification to this view in order to use the notifications properties within this view
    public func configure(with model: UserNotification) {
        self.notificationModel = model
        
        switch model.type {
        case .like(let post):
            let thumbnail: URL = post.thumbnailImage
            
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        
        label.text = model.text
        postImageView.image = UIImage(named: "profile_test_image")
//        postImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    //Used when a cell is going to be moved from its original position to another since the cells are always reused.
        //Have to set all of its properties to nil
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        postImageView.image = nil
//        label.text = nil
//        postButton.setTitle(nil, for: .normal)
//        postButton.setBackgroundImage(nil, for: .normal)
//        
//    }
    
    
    @objc private func didTapPostButton() {
        guard let model = notificationModel else {
            return
        }
        
        delegate?.didTapRelatedPostButton(model: model)
    }
}

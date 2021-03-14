//
//  NotificationFollowEventTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/10/21.
//

import UIKit

//Used for the controller to know what to do once that followButton is tapped
protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}


class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowEventTableViewCell"
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var notificationModel: UserNotification?
    
//    private let notificationModel: String?
    //Holds the profile picture of the person who followed you
    private let profileImageView: UIImageView = {
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
        label.text = "@kanye-west followed you."
        
        return label
    }()
    
    //The button that allows you to either follow the user back or unfollow
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
        configureForFollow()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Profile Image
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.frame.height-6, height: contentView.frame.height-6)
        profileImageView.layer.cornerRadius = contentView.frame.height/2
        
        //Post Button
        let buttonSize: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(x: contentView.frame.width - buttonSize - 5,
                                    y: (contentView.frame.height-buttonHeight)/2,
                                    width: buttonSize,
                                    height: buttonHeight)
        followButton.backgroundColor = .red
        
        //Label
        let labelWidth = contentView.frame.width - buttonSize - profileImageView.frame.width - 16
        label.frame = CGRect(x: profileImageView.frame.maxX + 5,
                             y: 0,
                             width: labelWidth,
                             height: contentView.frame.height)
    }
    
    @objc private func didTapFollowButton() {
        guard let model = notificationModel else {
            return
        }
        
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    
    //Saves the Notification to this view in order to use the notifications properties within this view: This will only configure a notification of type ".follow"
    public func configure(with model: UserNotification) {
        self.notificationModel = model
        
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            switch state {
            case .following:
                // Show Unfollow button
                configureForFollow()
            case .not_following:
                // Show Follow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            }
            
        }
        
        label.text = model.text
        profileImageView.image = UIImage(named: "profile_test_image")
//        postImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    
    private func configureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    //Used when a cell is going to be moved from its original position to another since the cells are always reused.
        //
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        profileImageView.image = nil
//        label.text = nil
//        followButton.setTitle(nil, for: .normal)
//        followButton.backgroundColor = nil
//        
//    }
}

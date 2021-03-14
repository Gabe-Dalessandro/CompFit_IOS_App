//
//  UserFollowTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/10/21.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(relationshipModel: UserRelationship)
}


struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}


//Cell that displays a user's info
//This is found when a user clicks on their follower, or following button from their profile
class UserFollowTableViewCell: UITableViewCell {
    static let identitifer = "UserFollowTableViewCell"
    static let cellHeight: CGFloat = 75.0
    
    weak var delegate: UserFollowTableViewCellDelegate?
    private var relationshipModel: UserRelationship?
    
    //Shows the profile picture of the user
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .darkGray
        
        return imageView
    }()
    
    //Shows the name of the User
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Joe"
        
        return label
    }()
    
    //Shows the username of the User
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "@joe"
        
        return label
    }()
    
    //Shows a butotn of either "Follow" or "Unfollow"
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Wont allow views within the cell leak over the cells bounds
        contentView.clipsToBounds = true
        
        //Add the subviews
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(userNameLabel)
        self.contentView.addSubview(followButton)
        
        //Add action to the follow button
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    //Handled by the delegate: will either follow or unfollow a user
    @objc private func didTapFollowButton() {
        guard relationshipModel != nil else {
            print("Error: No RelationshipModel exists")
            return
        }
        delegate?.didTapFollowUnfollowButton(relationshipModel: relationshipModel!)
    }
    
    //Lays out all of the subviews that we have as data members within the content view of the cell
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Profile Picture
        profileImageView.frame = CGRect(x: 3, y: 3, width: self.contentView.frame.height - 6, height: self.contentView.frame.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2.0
        
        //Follow Button: before labels in order to reference its size
        let buttonWidth = self.contentView.frame.width > 500 ? 220.0 : contentView.frame.width/3
        followButton.frame = CGRect(x: self.contentView.frame.width-5-buttonWidth, y: (self.contentView.frame.height-40)/2, width: buttonWidth, height: 40)
        
        //Name of user
        let labelHeight = self.contentView.frame.height/2
        let labelWidth = self.contentView.frame.width - profileImageView.frame.width - buttonWidth - 8
        nameLabel.frame = CGRect(x: profileImageView.frame.maxX+5, y: 0, width: labelWidth, height: labelHeight)

        //userNameLabel
        userNameLabel.frame = CGRect(x: profileImageView.frame.maxX+5, y: nameLabel.frame.maxY, width: labelWidth, height: labelHeight)

    }
    
    public func configure(relationshipModel: UserRelationship) {
        self.relationshipModel = relationshipModel
        
        nameLabel.text = relationshipModel.name
        userNameLabel.text = relationshipModel.username
        switch relationshipModel.type {
        case .following:
            //Show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemRed
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            //Show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
    
    //Set all of the data members fields to nil: So we can replace the fileds with a different user's data
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

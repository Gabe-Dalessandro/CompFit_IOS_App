//
//  ProfileInfoHeaderCollectionReusableView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/9/21.
//

import UIKit
import SDWebImage


protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    //FOR TESTING
    func profileHeaderDidTapProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
    
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}


//This goes at the Very top of the porfile page right about the posts. Shows the users profile info
final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        return button
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Posts", for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Following", for: .normal)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Followers", for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Edit Profile", for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.numberOfLines = 0 // 0 will line wrap
        return label
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        self.backgroundColor = .systemBackground
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Profile Picture
        let profilePhotoSize = self.frame.width/4.0
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize)
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        // Profile Button
        let profileButtonX = profilePhotoImageView.frame.maxX - 30
        let profileButtonY = profilePhotoImageView.frame.maxY - 30
        profileButton.frame = CGRect(x: profileButtonX, y: profileButtonY, width: 30, height: 30)
        profileButton.layer.cornerRadius = 15/2
        profileButton.backgroundColor = .white
               

        //Posts, Following, and Followers
        let buttonHeight = profilePhotoSize/2.0
        let buttonWidth = (self.frame.width - profilePhotoSize - 10)/3
        postsButton.frame = CGRect(x: profilePhotoImageView.frame.maxX, y: 5, width: buttonWidth, height: buttonHeight)
        followersButton.frame = CGRect(x: postsButton.frame.maxX, y: 5, width: buttonWidth, height: buttonHeight)
        followingButton.frame = CGRect(x: followersButton.frame.maxX, y: 5, width: buttonWidth, height: buttonHeight)
        
        //Edit Profile Button
        editProfileButton.frame = CGRect(x: profilePhotoImageView.frame.maxX, y: 5+buttonHeight, width: (buttonWidth * 3), height: buttonHeight)
        
        
        //Labels
        nameLabel.frame = CGRect(x: 5, y: 5+profilePhotoImageView.frame.maxY, width: self.frame.width-10, height: 50)
        
        let bioLabelSize = bioLabel.sizeThatFits(self.frame.size)
        bioLabel.frame = CGRect(x: 5, y: 5+nameLabel.frame.maxY, width: self.frame.width-10, height: bioLabelSize.height)

    }
    
    
    private func addButtonActions(){
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    
    private func addSubviews(){
        self.addSubview(profilePhotoImageView)
        self.addSubview(postsButton)
        self.addSubview(followersButton)
        self.addSubview(followingButton)
        self.addSubview(editProfileButton)
        self.addSubview(nameLabel)
        self.addSubview(bioLabel)
        self.addSubview(profileButton)
    }
    
    
    func configure(with userModel: UserModel){
        if userModel.profilePicture != nil {
            // print( "Getting image for profile picture from AWS: \(String(describing: userModel.profilePicture?.absoluteString))" )
            profilePhotoImageView.sd_setImage(with: userModel.profilePicture, completed: nil)
        }
        nameLabel.text = userModel.email
        bioLabel.text = userModel.userDesc
    }
    
    
    // FOR TESTING
    @objc private func didTapProfileButton() {
        delegate?.profileHeaderDidTapProfileButton(self)
    }
    
    
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}

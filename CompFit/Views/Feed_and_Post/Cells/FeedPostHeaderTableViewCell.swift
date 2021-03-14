//
//  FeedPostHeaderTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/8/21.
//

import SDWebImage
import UIKit

protocol FeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}


//Header info about a post like the user who posted it, where it was taken etc
class FeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier = "FeedPostHeaderTableViewCell"
    static let cellHeight: CGFloat = 70
    weak var delegate: FeedPostHeaderTableViewCellDelegate?
    
    // Holds profile picture of user who created the post
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // Username of the user who created the post
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    // Button that holds other options to interact with the post
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        return button
    }()
    
    
    
    
    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(profilePhotoImageView)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(moreButton)
        
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    @objc private func didTapMoreButton(){
        delegate?.didTapMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserModel) {
        usernameLabel.text = model.email
        profilePhotoImageView.image = UIImage(named: "tyler_test")
        // profilePhotoImageView.sd_setImage(with: model.profilePicture, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Profile Photo
        let size = contentView.frame.height - 10
        profilePhotoImageView.frame = CGRect(x: 2, y: 4, width: size, height: size)
        profilePhotoImageView.layer.cornerRadius = size/2
        
        // More Button
        moreButton.frame = CGRect(x: contentView.frame.width - size, y: 2, width: size, height: size)
        
        // Username
        usernameLabel.frame = CGRect(x: profilePhotoImageView.frame.maxX + 10, y: 2, width: contentView.frame.width - (size * 2) - 15, height: contentView.frame.height - 4)
        
    }
    
    
    override func prepareForReuse() {
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }
}

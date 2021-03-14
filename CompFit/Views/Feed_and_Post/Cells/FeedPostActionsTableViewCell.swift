//
//  FeedPostActionsTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/8/21.
//

import UIKit

protocol FeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}



//Holds items that allow users to interact with the post: things like the like button, the share button, and
class FeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "FeedPostActionsTableViewCell"
    static let cellHeight: CGFloat = 60
    weak var delegate: FeedPostActionsTableViewCellDelegate?
    
    // Like Button: likes a post
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    // Comment Button: adds a comment to the post
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    // Send Button: send a post in a direct message
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    
    
    
    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add Subviews
        self.contentView.addSubview(likeButton)
        self.contentView.addSubview(commentButton)
        self.contentView.addSubview(sendButton)
        
        // Add actions to buttons
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton() {
        delegate?.didTapSendButton()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize = contentView.frame.height - 10
        
        // Like button
        likeButton.frame = CGRect(x: 2, y: 5, width: buttonSize, height: buttonSize)
        
        // Comment button
        commentButton.frame = CGRect(x: 2 + buttonSize, y: 5, width: buttonSize, height: buttonSize)
        
        // Send button
        sendButton.frame = CGRect(x: 2 + buttonSize + 50, y: 5, width: buttonSize, height: buttonSize)
    }

    
    // Set all buttons back to original state
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

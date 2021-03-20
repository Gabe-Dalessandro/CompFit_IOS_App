//
//  ProfileTabsCollectionReusableView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/9/21.
//

import UIKit


protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}


//This section holds the tabs that will change the content chown on the profile screen
//Has 2 tabs:
//1) Posts
//2) Tagged Posts
class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    static let viewHeight: CGFloat = 40
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    //button to display the posts created by the user
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        
        return button
    }()
    
    //button to display the posts where user was tagged
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        
        return button
    }()
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        self.addSubview(gridButton)
        self.addSubview(taggedButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = self.frame.height - 10
        let gridXPos = (self.frame.width/4)-(buttonSize/2)
        gridButton.frame = CGRect(x: gridXPos, y: 5, width: buttonSize, height: buttonSize)
        taggedButton.frame = CGRect(x: gridXPos + (self.frame.width/2), y: 5, width: buttonSize, height: buttonSize)
    }
    
    
    //Will change the color of the buttons and display the user's posts
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    
    //Will change the color of the buttons and display the user's tagged posts
    @objc private func didTapTaggedButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButtonTab()
    }
    
}


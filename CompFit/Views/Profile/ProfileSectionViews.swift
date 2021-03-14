//
//  ProfileSectionViews.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/4/21.
//

import UIKit

class ProfileSectionPageControl: UIView {
    
    var buttonFontSize = 0
    var scrollView = UIScrollView()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Constants.deepOrange
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.backgroundColor = .blue
                
        return pageControl
    }()
    
    
    //For Playlists
    private let playlistButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Playlists", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //For Posts
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Posts", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //For Activity
    private let activityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Activity", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let horizStackView = UIStackView()
    var buttonArray: [UIButton] = []
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func assignScrollView(assigned: UIScrollView){
        self.scrollView = assigned
    }
    
    func setProfileSectionControl(superview: UIView, aboveView: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 10).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 17).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -17).isActive = true
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Add the Horizontal Stack View holding the buttons
        self.addSubview(horizStackView)
        horizStackView.axis = .horizontal
        horizStackView.distribution = .equalSpacing
        horizStackView.addArrangedSubview(playlistButton)
        horizStackView.addArrangedSubview(postButton)
        horizStackView.addArrangedSubview(activityButton)
        
        horizStackView.backgroundColor = .blue
        horizStackView.translatesAutoresizingMaskIntoConstraints = false
        horizStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        horizStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        horizStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        buttonArray = [playlistButton, postButton, activityButton]
    }
    
    
    
//    func setProfilePageControl(superview: UIView, aboveView: UIView){
//        superview.addSubview(pageControl)
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
//        pageControl.leadingAnchor.constraint(equalTo: aboveView.leadingAnchor).isActive = true
//        pageControl.trailingAnchor.constraint(equalTo: aboveView.trailingAnchor).isActive = true
//
//    }

    
}




class ProfileSectionScrollView: UIScrollView {
        
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProfileSectionScrollView(superview: UIView, aboveView: UIView){
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 5).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 17.0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -17.0).isActive = true
//        self.heightAnchor.constraint(equalToConstant: 260).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true

        
//        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .red
        self.isPagingEnabled = true

        //Need to figure out what to make the height in order to allow for scrolling when theres a lot of content
//        self.contentSize = CGSize(width: (superview.frame.width * 3.0), height: 500)

    }
}

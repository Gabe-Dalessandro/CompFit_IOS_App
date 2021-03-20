//
//  ProfileViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/9/21.
//

import UIKit


/// Profile View Controller
final class ProfileViewController: UIViewController {

    private var profileCollectionView: UICollectionView?
    private var userPosts = [UserPost]()
    let userdata: UserModel
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Will display someone else's profile
    init(foreignUser userData: UserModel){
        self.userdata = userData
        super.init(nibName: nil, bundle: nil)
        self.title = "Profile"
        self.navigationItem.title = userdata.email
    }
    
    
    //Will display the app user's profile
    init(){
        self.userdata = UserDefaults.standard.getCurrentUser()
        super.init(nibName: nil, bundle: nil)
        self.title = "Profile"
        self.navigationItem.title = userdata.email
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileCollectionView?.frame = view.bounds
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureProfileCollectionView()
    }
        
    
    private func configureProfileCollectionView() {
        //Create the layout for the collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: view.frame.width, height: 1800.0)
        
        //Create the collection view
        profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Register the headers
            // Profile Info header
        profileCollectionView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
            // Tabs for posts and tagged posts
        profileCollectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        // Register the cells
        profileCollectionView?.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        
        profileCollectionView?.delegate = self
        profileCollectionView?.dataSource = self

        // Add the collection view to the layout
        view.addSubview(profileCollectionView!)
    }
    
    
    @objc
    private func didTapSettingsButton() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    
    func didFinishEditing(){
        profileCollectionView?.reloadData()
    }
    
}



// This collection view has 2 sections
    //Section 1: Profile Info
    //Section 2: Content Tabs (for user content like playlists, activity, etc)
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // How many sections the collection view will have
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    // How many cells will be in certain sections
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //For profile info section
        if section == 0 {
            return 0
        }
        //For content tabs section
        else {
            //return userPosts.count
            return 1
        }
    }
    
    
    // Creates the cells we will see within the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        if indexPath.section == 1 {
            let cell = profileCollectionView?.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as! SectionCollectionViewCell
            
//            cell.configure(with: [UserPost]())
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    // When a user clicks on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    // Says what header we should use for our collection view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // If a footer comes up
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        // For Section 1: Profile Info
        if indexPath.section == 0 {
            let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
            
            profileHeader.configure(with: userdata)
            profileHeader.delegate = self
            return profileHeader
        }
        // For Section 2: Content Tabs
        else {
            let contentTabsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            return contentTabsHeader
        }
    }
    
    
    // Gives the collecion view header a height for a specific section
        // There will be multiple sections in a collection view in most cases
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //For the first section (Profile Info)
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
        }
        //For the second section (Tabs for user content. ie playlists, activity, workouts)
        else {
            return CGSize(width: collectionView.frame.width, height: ProfileTabsCollectionReusableView.viewHeight)
        }
    }
}







// Implements function within the profile info header
extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    
    //To change the profile picture
    func profileHeaderDidTapProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let cameraVC = CameraViewController()
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window?.layer.add(transition, forKey: "from_left")
        
        self.navigationController?.pushViewController(cameraVC, animated: false)
    }
    
    
    
    //Scroll to the posts section within our collection view
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        profileCollectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    
    //Open up the list controller for Followers
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        mockData.append(UserRelationship(username: "@kinginthenorth", name: "Rob Stark", type: .following))
        for i in 0...9{
            mockData.append(UserRelationship(username: "@joe", name: "Joe", type: i%2 == 0 ? .following :.not_following))
        }
        
        let listVC = ListViewController(dataToDisplay: mockData)
        listVC.title = "Followers"
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    
    // Opens up the list controller to show who the user is following
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        mockData.append(UserRelationship(username: "@kinginthenorth", name: "Rob Stark", type: .following))
        for i in 0...9{
            mockData.append(UserRelationship(username: "@joe", name: "Joe", type: i%2 == 0 ? .following :.not_following))
        }
        
        let listVC = ListViewController(dataToDisplay: mockData)
        listVC.title = "Following"
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    
    // Edits the profile by bringing up the controller
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let editVC = EditProfileViewController()
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}







extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //get the page index when we are scrolling on the scroll view
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        
//        pageControl.currentPage = Int(pageIndex)
    }
    
}




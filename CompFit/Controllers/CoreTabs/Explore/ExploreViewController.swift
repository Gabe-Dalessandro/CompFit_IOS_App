//
//  ExploreViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/9/21.
//

import UIKit


//A user will be able to discover new content from users they follow, or from a TikTok type feature, or from a tab that serves content that is similar to their interests/history
class ExploreViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var explorePostModels = [UserPost]()
    
    // Will search for different types of content
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        searchBar.placeholder = "Search"
        
        return searchBar
    }()
    
    // Holds additional Tabs right below the search bar that will show different views
    private var tabbedSearchCollectionView: UICollectionView?
    
    // Dims the screen when the user clicks search
    private let dimmedView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .black
        view.alpha = 0.0
        
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
        
        
        configureExploreCollection()
        configureDimmedView()
    }
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Explore"
        self.tabBarItem.image = UIImage(named: "explore_icon")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
    }
    
    // Dimmed view when searching
    private func configureDimmedView() {
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    
    
    // For tabs below the search bar
    private func configureTabbedSearch() {
        // Create the layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/3, height: 52)
        
        
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        
        view.addSubview(tabbedSearchCollectionView!)
    }
    
    private func configureExploreCollection() {
        // Create the layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.frame.width - 4)/3.0, height: (view.frame.width - 4)/3.0)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Register cells
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identitifer)
        
        // Add delegates
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        // Add the collection view to the main view
        view.addSubview(collectionView!)
    }
}







// Search Bar Delegate
extension ExploreViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(didCancelSearch)
        )
        
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0.4
        }
    }
    
    @objc private func didCancelSearch() {
        // Get rid of keyboard
        searchBar.resignFirstResponder()
        // Get rid of text in the search bar
        searchBar.text = nil
        // Get rid of cancel button
        navigationItem.rightBarButtonItem = nil
        
        // Dismiss the dimmed view and change the alpha
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.0
        }) { done in
            if done {
                self.dimmedView.isHidden = true
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        
        // If there is NO text in the search bar
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        //if text is in the search bar
        query(text: text)
    }
    
    //Performs search in the Backend
    private func query(text: String){
        
    }
    
}



// Collection View Delegate
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identitifer, for: indexPath) as! PhotoCollectionViewCell
        photoCell.configure(debug: "test")
        return photoCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let user = UserModel(email: "gdalessa",
                             password: "fitness123",
                             phoneNumber: "5707936087",
                             birthday: "1943-09-19",
                             totalPoints: 0,
                             gender: "Female",
                             fitnessExp: "Beginner",
                             workoutIntensity: "High",
                             workoutTypes: ["HIIT"])
        
        let post = UserPost(identifier: "",
                            owner: user,
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com/")!,
                            postURL: URL(string: "https://www.google.com/")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            dateCreated: Date(),
                            taggedUsers: [])
        
        // let model = explorePostModels[indexPath.row]
        let postVC = PostViewController(model: post)
        postVC.title = post.postType.rawValue
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
}



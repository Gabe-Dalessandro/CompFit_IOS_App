//
//  PostSectionCollectionViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/14/21.
//

import UIKit

// A collection view cell that uses a collection view to display Posts within the profile page
class PostSectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostSectionCollectionViewCell"
    private let models = [UserPost]()
    private var collectionView: UICollectionView?
        

    
    
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView?.frame = contentView.bounds
    }
    
    
    private func configureCollectionView() {
        //Create the layout for the collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        let sizeOfPosts = (frame.width-6)/3.0
        layout.itemSize = CGSize(width: sizeOfPosts, height: sizeOfPosts)

        //Create the collection view
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView?.isScrollEnabled = false
        
        // Set delegates
        collectionView?.delegate = self
        collectionView?.dataSource = self

        // Register cells
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identitifer)
        
        // Add the collection view as a subview
        contentView.addSubview(collectionView!)
    }
}




extension PostSectionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identitifer, for: indexPath) as! PhotoCollectionViewCell

        postCell.configure(debug: "profile_test_image")
        return postCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get the model that was clicked and open the post view controller
//        print(indexPath.row)
//        print(indexPath)
//        let postModel = userPosts[indexPath.row]
//        let postVC = PostViewController(model: postModel)
//        self.navigationController?.pushViewController(postVC, animated: true)
    }
}

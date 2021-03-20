//
//  SectionCollectionViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/14/21.
//

import UIKit


// A colletion view Cell that holds the different section of posts on the Profile Page using a collection view itself
    // 1st Section: Posts
    // 2md Section: Tagged Posts
class SectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "SectionCollectionViewCell"
    private var collectionView: UICollectionView?
    private var models = [UserPost]()
        
        
        
    
    
    
    
    
    
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
        // Create the layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        
        // Create the collection view using the layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .blue
        collectionView?.isPagingEnabled = true
        
        // Register the Cells
        collectionView?.register(PostSectionCollectionViewCell.self, forCellWithReuseIdentifier: PostSectionCollectionViewCell.identifier)

        // Set the delegates
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        contentView.addSubview(collectionView!)
    }

    func configure(with models: [UserPost]) {
        self.models = models
        collectionView?.reloadData()
    }
}





extension SectionCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostSectionCollectionViewCell.identifier, for: indexPath) as! PostSectionCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

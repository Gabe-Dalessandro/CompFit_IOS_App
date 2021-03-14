//
//  PhotoCollectionViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/9/21.
//

import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identitifer = "PhotoCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //Will ensure that the image takes up the entire view/size of the cell that its in
    //contentView is the entire cell
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        //ensures that no part of the cells overflows outside of the main area
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //What will be used in production
    public func configure(with model: UserPost) {
        let thumbnailURL = model.thumbnailImage
        self.photoImageView.sd_setImage(with: thumbnailURL, completed: nil)
        
        
        //Doing the image downloading ourselves
//        let task = URLSession.shared.dataTask(with: thumbnailURL, completionHandler: { data, _, _ in
//            self.photoImageView.image = UIImage(data: data!)
//        })
//        task.resume()
    }
    
    
    //To test our code
    public func configure(debug imageName: String) {
        photoImageView.image = UIImage(named: "profile_test_image")
    }
    
}


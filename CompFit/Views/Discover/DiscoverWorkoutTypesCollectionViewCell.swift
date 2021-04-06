//
//  DiscoverWorkoutTypesCollectionViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/31/21.
//

import UIKit

class DiscoverWorkoutTypesCollectionViewCell: UICollectionViewCell {
    static let identifier = "DiscoverWorkoutTypesCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "test-workout-type3")
        imageView.image = image
        return imageView
    }()
    
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        imageView.layer.cornerRadius = 10
    }
    
    public func setImageViewImage(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
}

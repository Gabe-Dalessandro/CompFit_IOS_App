//
//  DiscoverFeaturedTrainersCollectionViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 4/1/21.
//

import UIKit

class DiscoverFeaturedTrainersCollectionViewCell: UICollectionViewCell {

    static let identifier = "DiscoverFeaturedTrainersCollectionViewCell"
    
    private let featuredView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.Colors.brandPink
        view.clipsToBounds = true
        
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Constants.Colors.brandBlue
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsMedium(size: 18)
        label.textColor = .white
        label.numberOfLines = 0 // 0 will line wrap
        label.textAlignment = .left
        
        // Creates smaller spacing between line breaks
        let attributedString = NSMutableAttributedString(string: "Michael\nKorrs")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = 0.70
        paragraphStyle.alignment = .left
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
    
        label.attributedText = attributedString
        
        return label
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsLight(size: 13)
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0 // 0 will line wrap
        
        // Creates smaller spacing between line breaks
        let attributedString = NSMutableAttributedString(string: "Lean Physique Training")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = 0.70
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        label.attributedText = attributedString
        
        return label
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        
        contentView.addSubview(featuredView)
        featuredView.addSubview(profileImageView)
        featuredView.addSubview(nameLabel)
        featuredView.addSubview(taglineLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Featured View
        featuredView.frame = contentView.bounds
        
        
        // Profile Image
        let imageViewSize = contentView.frame.height * (0.60)
        let imageY = (contentView.frame.height/2.0) - (imageViewSize/2)
        profileImageView.frame = CGRect(x: 20, y: imageY, width: imageViewSize, height: imageViewSize)
        profileImageView.layer.cornerRadius = imageViewSize/2
        
        // Name Label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imageY-5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: nameLabel.intrinsicContentSize.height + 5).isActive = true
        
        // Tagline Label
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        taglineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        taglineLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15).isActive = true
        taglineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        taglineLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    
}

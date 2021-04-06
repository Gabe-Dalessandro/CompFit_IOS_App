//
//  DiscoverFeaturedTrainersSectionHeader.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 4/1/21.
//

import UIKit

protocol DiscoverFeaturedTrainersSectionHeaderDelegate: AnyObject {
    func didTapViewAll()
}

class DiscoverFeaturedTrainersSectionHeader: UICollectionReusableView {
    
    weak var delegate: DiscoverFeaturedTrainersSectionHeaderDelegate?
    static let identifier = "DiscoverFeaturedTrainersSectionHeader"
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsBold(size: 22)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Featured Trainers"
        
        return label
    }()
    
    
    let viewAll: UILabel = {
        let label = UILabel()
        label.font = UIFont.poppinsMedium(size: 16)
        label.textColor = Constants.Colors.brandBlue
        label.textAlignment = .left
        label.text = "View All"
        
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapViewAll))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        label.addGestureRecognizer(gesture)
        
        return label
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        addSubview(viewAll)
        
        // Add interaction to "View All"
        viewAll.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapViewAll))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        viewAll.addGestureRecognizer(gesture)
        
        // USING STACK VIEW WITH A SEPERATOR LINE
//        let seperatorLine = UIView(frame: .zero)
//        seperatorLine.translatesAutoresizingMaskIntoConstraints = false
//        seperatorLine.backgroundColor = .quaternaryLabel
//
//        let stackView = UIStackView(arrangedSubviews: [seperatorLine, title])
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        addSubview(stackView)
//
//        NSLayoutConstraint.activate([
//            seperatorLine.heightAnchor.constraint(equalToConstant: 1),
//
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
//        ])
//
//        stackView.setCustomSpacing(10, after: seperatorLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleLabelSize = title.sizeThatFits(self.frame.size)
        title.frame = CGRect(x: 0, y: 0, width: titleLabelSize.width, height: titleLabelSize.height)
        
        
        let viewAllLabelSize = viewAll.sizeThatFits(self.frame.size)
        viewAll.frame = CGRect(x: frame.maxX - viewAllLabelSize.width - 8, y: 4, width: viewAllLabelSize.width, height: viewAllLabelSize.height)
//        NSLayoutConstraint.activate([
//            viewAll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
//        ])

    }
    
    
    @objc private func didTapViewAll(){
        delegate?.didTapViewAll()
    }
    
}

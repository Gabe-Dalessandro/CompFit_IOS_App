//
//  FeedPostGeneralTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/8/21.
//

import UIKit

// Holds data like Comments
class FeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "FeedPostGeneralTableViewCell"
    static let cellHeight: CGFloat = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.Colors.brandLightGrey
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureWithModel() {
        //Configure model
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

//
//  FeedTableViewCell.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/8/21.
//

import SDWebImage
import AVFoundation
import UIKit


//Holds the primary content of the actual post that was made (ie the picture/video)
class FeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostTableViewCell"
    
    static func cellHeight(tableView: UITableView) -> CGFloat{
        return tableView.frame.width
    }
    
    private var videoPlayer: AVPlayer?
    private var videoPlayerLayer = AVPlayerLayer()
    
    //Holds the picture or video that will be displayed
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = nil
        
        return imageView
    }()
    
    

    
    
    
    
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        self.contentView.layer.addSublayer(videoPlayerLayer) //Add layer before other subviews
        
        //Add the subviews
        self.contentView.addSubview(contentImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        contentImageView.image = UIImage(named: "profile_test_image")
        
        return
        
        switch post.postType {
        case .photo:
            // Show the photo
            contentImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            // Play the video
            videoPlayer = AVPlayer(url: post.postURL)
            videoPlayerLayer.player = videoPlayer
            videoPlayerLayer.player?.volume = 0
            videoPlayerLayer.player?.play()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoPlayerLayer.frame = self.contentView.bounds
        contentImageView.frame = self.contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
    }
}

//
//  PlaylistView.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/6/21.
//

import UIKit

class WorkoutPlaylistObjView: UIView {
    var playlistObject: PlaylistModel
    
    init(superview: UIView, playlistObj: PlaylistModel, abovieView: UIView? = nil) {
        self.playlistObject = playlistObj
        super.init(frame: CGRect())
        superview.addSubview(self)
        self.backgroundColor = .purple
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.widthAnchor.constraint(equalToConstant: 320).isActive = true
        
        //
        let nameLabel = UILabel()
        nameLabel.text = playlistObject.playlistName
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWorkoutPlaylist(superview: UIView, index: Int){
        
    }
    
}

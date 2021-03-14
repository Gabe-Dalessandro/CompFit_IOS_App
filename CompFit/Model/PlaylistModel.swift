//
//  PlaylistModel.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/6/21.
//

import UIKit


class PlaylistModel: Codable {
    var id: Int
    var playlistName: String
    var owner: Int
    var dateCreated: String
    
    
    //only include keys you want to send to backend
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case playlistName = "playlist_name"
        case owner = "owner"
        case dateCreated = "date_created"
    }
    
    func printWorkoutPlaylist(){
        var returnStr = "Workout Playlist Object: " + String(id) + "\n"
        returnStr += "Playlist Name: " + self.playlistName + "   Owned By: " + String(owner)
        print(returnStr)
    }
    
}

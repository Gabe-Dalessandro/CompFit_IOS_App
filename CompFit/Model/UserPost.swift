//
//  UserPost.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/9/21.
//

import UIKit

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}


public struct UserPost {
    let identifier: String
    let owner: UserModel
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let dateCreated: Date
    let taggedUsers: [String]
}


struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let dateCreated: Date
    let likes: [CommentLike]
}

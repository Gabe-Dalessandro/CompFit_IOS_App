//
//  UserNotification.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/10/21.
//

import UIKit


enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}


struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: UserModel
}

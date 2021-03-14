//
//  HTTPRequests.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/15/21.
//
// USING LOCALHOST: http://localhost:8000/
// USING AWS: http://ec2-54-219-66-205.us-west-1.compute.amazonaws.com:8000/

import UIKit


struct Endpoint {
    var app: String
    var path: String
    var queryItems: [URLQueryItem] = [] //[name : value] pairs
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "localhost"
        // components.host = "ec2-54-219-66-205.us-west-1.compute.amazonaws.com"
        components.port = 8000
        components.path = "/api/" + app + path
        
        // makes the url
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
}




class HTTPRequests {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    //Login and Registration
    static let register_user_str = "http://localhost:8000/api/user/register/"
    static let get_workout_types = "http://localhost:8000/api/user/workout_type/get/"
    static let login_user = "http://localhost:8000/api/user/login/"
    
    //User Profile
    static let update_profile_picture = "http://localhost:8000/api/user_profile/profile_picture/update/"
    static let get_current_profile_picture = "http://localhost:8000/api/user_profile/profile_picture/get/"
    
//    static let register_user_str = "http://ec2-54-219-66-205.us-west-1.compute.amazonaws.com:8000/api/user/register/"
//
//    static let get_workout_types = "http://ec2-54-219-66-205.us-west-1.compute.amazonaws.com:8000/api/workout_type/get/"
//
//    static let login_user = "http://ec2-54-219-66-205.us-west-1.compute.amazonaws.com:8000/api/user/login/"
    
}

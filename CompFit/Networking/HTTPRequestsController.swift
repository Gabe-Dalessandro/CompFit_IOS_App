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
//        components.host = "localhost"
        components.host = "192.168.254.25"
//        components.host = "ec2-3-101-115-249.us-west-1.compute.amazonaws.com"
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
    

}

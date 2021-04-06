//
//  DiscoverNetworking.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 4/1/21.
//

import Foundation


import Foundation

extension Endpoint {
    static func searchUsers(parameter: String) -> Self {
        Endpoint(app: "user/", path: "search/get/\(parameter)/")
    }
    
    static var searchUsers: Self {
        Endpoint(app: "user_profile/", path: "profile_picture/update/")
    }
}




class DiscoverNetworking {

    // Searches the database based on a parameter string that was passed in by the search bar
    // Returns an array of UserModels to populate the SearchResults Table for the Discover page
    static func searchUsers(searchParameter: String) -> [UserModel] {
        print("\n\n=== Searching Database based on Search Query: \(searchParameter) ===\n")
        let myGroup = DispatchGroup()
        myGroup.enter()
        var userResults = [UserModel]()

        //Create the request
        let endpoint = Endpoint.searchUsers(parameter: searchParameter)
        var urlRequest = URLRequest(url: endpoint.url)
        
        // Construct the request
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        //Create a URL Session
        let session = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if (error != nil) {
                print("\n=== Error in Search request \(endpoint.path) ===")
                print(error!)
            } else {
                //ensure the response status is 200 OK and that there is data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let validData = data else {
                        //completion(.failure(.responseProblem))
                    return
                }

                do {
                    let responseData = try JSONDecoder().decode([UserModel].self, from: validData)
                    print("\n=== Search Completed Successfully ===\n")
                    userResults = responseData
                    myGroup.leave()
                } catch {
                    print("\n=== Error in getUsersWorkoutPlaylists request \(endpoint.path) ===")
                    myGroup.leave()
                }
            }
        }
        session.resume()

        myGroup.wait()
        return userResults
    }

    
    
}


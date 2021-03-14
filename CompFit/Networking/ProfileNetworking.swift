//
//  ProfileNetworking.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/6/21.
//

import Foundation

extension Endpoint {
    static func getPlaylists(withID id: Int) -> Self {
        Endpoint(app: "user_profile/", path: "workout_playlist/get/\(id)/")
    }
}


class ProfileNetworking {
    
    static func getUsersWorkoutPlaylists() -> [PlaylistModel] {
        print("\n\n=== Retrieved Workout Playlists for User's Profile ===\n")
        let myGroup = DispatchGroup()
        myGroup.enter()
        var retrievedPlaylists: [PlaylistModel] = []
        let currentUser = UserDefaults.standard.getCurrentUser()

        //Create the request
        let endpoint = Endpoint.getPlaylists(withID: currentUser.id!)
        var urlRequest = URLRequest(url: endpoint.url)

        // Construct the request
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        //Create a URL Session
        let session = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if (error != nil) {
                print("\n=== Error in getUsersWorkoutPlaylists request \(endpoint.path) ===")
                print(error!)
            } else {
                //ensure the response status is 200 OK and that there is data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let validData = data else {
                        //completion(.failure(.responseProblem))
                    return
                }

                do {
                    let responsePlaylists = try JSONDecoder().decode([PlaylistModel].self, from: validData)
                    print("\n=== Successfully Retrieved Playlists ===\n")
//                    for p in responsePlaylists {
//                        p.printWorkoutPlaylist()
//                    }
                    retrievedPlaylists = responsePlaylists
                    myGroup.leave()
                } catch {
                    print("\n=== Error in getUsersWorkoutPlaylists request \(endpoint.path) ===")
                    myGroup.leave()
                }
            }
        }
        session.resume()
        
        myGroup.wait()
        return retrievedPlaylists
    }
    
}




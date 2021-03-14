//
//  RegistrationNetworking.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/4/21.
//

import Foundation

extension Endpoint {
    static var register: Self {
        Endpoint(app: "user/", path: "register/")
    }
}


class RegisterNetworking {
    
    static func registerNewUser(userData newUser: UserModel) {
        let myGroup = DispatchGroup()
        myGroup.enter()
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(newUser)
        
        // Construct the request using the url
        let endpoint = Endpoint.register
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        // Create a task to do using a session
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if (error != nil) {
                print("\n=== Error in POST request 'user/post' ===")
                print(error ?? "error")
            } else {
                //ensure the response status is 200 OK and that there is data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let validData = data else {
//                            completion(.failure(.responseProblem))
                    return
                }
                
                // runs if we get the data from the response
                do {
                    let newUserData = try JSONDecoder().decode(UserModel.self, from: validData)
                    print("\n\n=== Registration Successful! ===")
                    newUserData.printUserModel()
                    
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setCurrentUser(newUserData, writeToUserDefaults: true)
                    myGroup.leave()
                } catch {
                    print("error from response in 'user/post'")
                    myGroup.leave()
                }
            }
        }
        dataTask.resume()
        
        
        myGroup.wait()
    }
    
}

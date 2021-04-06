//
//  LoginNetworking.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/4/21.
//

import Foundation

extension Endpoint {
    static var login: Self {
        Endpoint(app: "user/", path: "login/")
    }
}


class LoginNetworking {
    
    // Successful login will mean no error was returned and the string will be empty ""
    static func loginUser(_ email: String, _ password: String) -> String {
        let myGroup = DispatchGroup()
        myGroup.enter()

        var successfulLogin = ""

        // Create the user and convert it JSON
        let user = UserModel(email: email, password: password)
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(user)

        //Create the request
        let endpoint = Endpoint.login
        var urlRequest = URLRequest(url: endpoint.url)

        // Construct the request
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData

        //Create a URL Session
        let session = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if (error != nil) {
                print("\n=== Error in LOGIN request 'user/login' ===")
                print(error!)
            } else {
                //ensure the response status is 200 OK and that there is data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let validData = data else {
                        //completion(.failure(.responseProblem))
                    return
                }

                do {
                    let loggedInUser = try JSONDecoder().decode(UserModel.self, from: validData)

                    UserDefaults.standard.setCurrentUser(loggedInUser, writeToUserDefaults: true)
                    UserDefaults.standard.setIsLoggedIn(value: true)


                    print("\n\n=== Login Successful! ===")
                    loggedInUser.printUserModel()
                    successfulLogin = ""
                    myGroup.leave()
                } catch {
                    let loginError = try! JSONDecoder().decode(String.self, from: validData)
                    
                    print("\n\nError in LOGIN request: \(loginError)")
                    successfulLogin = loginError
                    myGroup.leave()
                }
            }
        }
        
        session.resume()

        myGroup.wait()
        return successfulLogin
    }
    
}

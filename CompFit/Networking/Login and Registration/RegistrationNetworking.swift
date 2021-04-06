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
    
    static var register2: Self {
        Endpoint(app: "user/", path: "register2/")
    }
    
    static var onboard: Self {
        Endpoint(app: "user/", path: "onboard/")
    }
    
    static var getWorkoutTypes: Self {
        Endpoint(app: "user/", path: "workout_type/get/")
    }
    
}


class RegisterNetworking {
    
    // Creates a user object and then sends it to the backend
    static func registerNewUser2(userData newUser: UserModel) -> String {
        var successfulRegistration = ""
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(newUser)
        
        // Construct the request using the url
        let endpoint = Endpoint.register2
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            if (error != nil) {
                print("\n=== Error in POST request 'user/post' ===")
                print(error ?? "error")
            } else {
                // Ensure the response status is 200 OK and that there is data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let validData = data else {
//                            completion(.failure(.responseProblem))
                    return
                }
                
                
                do {
                    let newUserData = try JSONDecoder().decode(UserModel.self, from: validData)
                    print("\n\n=== Registration Successful! ===")
                    newUserData.printUserModel()
                    
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setCurrentUser(newUserData, writeToUserDefaults: true)
//                    UserDefaults.standard.setHasCompletedOnboarding(value: false)
                    
                    
                    successfulRegistration = ""
                    myGroup.leave()
                } catch {
                    let errorMessage = try! JSONDecoder().decode(String.self, from: validData)
                    print("error from response in 'user/post': \(errorMessage)")
                    successfulRegistration = errorMessage
                    myGroup.leave()
                }
            }
        }
        dataTask.resume()
        
        myGroup.wait()
        return successfulRegistration
    }
    
    
    
    // Onboard the user: update remaining fields for the user in the database
    static func onboardUser(userData updatedUser: UserModel) {
        let myGroup = DispatchGroup()
        myGroup.enter()
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(updatedUser)
        
        // Construct the request using the url
        let endpoint = Endpoint.onboard
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
    
    
    
    
    
    
    
    
    
    // Creates a user object and then sends it to the backend
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
    
    
    
    
    // Retrieves all of the workout types that are saved within the database
    static func getWorkoutTypes() -> [String]{
        var workoutTypes = [String]()
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        let endpoint = Endpoint.getWorkoutTypes
        let task = URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
            if error != nil {
                print("Error within: \(endpoint.url)")
                print(error!)
            }

            if let safeData = data {
                let results = try! JSONDecoder().decode([String].self, from: safeData)
                workoutTypes = results
                dispatchGroup.leave()
            } else {
                print("Error within: \(endpoint.url)")
                print("\terror when grabbing data")
                return
            }
        }
        task.resume()
        
        dispatchGroup.wait()
        return workoutTypes
    }
    
}

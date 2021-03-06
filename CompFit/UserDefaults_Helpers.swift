//
//  UserDefaults_Helpers.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/7/21.
//

import Foundation

extension UserDefaults {
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
    
    
    func setCurrentUser(_ user: UserModel, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults == true {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: "currentUser")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    
    func getCurrentUser() -> Any {
        let byteBuffer = data(forKey: "currentUser")
                
        do {
            let currentUser = try JSONDecoder().decode(UserModel.self, from: byteBuffer!)
            return currentUser
        } catch {
            print("error in User Defaults")
        }
        
        return "error in User Defaults"
    }
    
}

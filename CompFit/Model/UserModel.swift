//
//  UserModel.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 1/23/21.
//

import Foundation

struct UserModel: Codable {
    var id: Int? = 0
    var firstName: String? = ""
    var lastName: String? = ""
    var email: String?
    var password: String?
    var phoneNumber: String?
    var birthday: String?
    var totalPoints: Int?
    //Foreign Keys
    var gender: String?
    var fitnessExp: String?
    var workoutIntensity: String?
    var workoutTypes: [String]?
    
   
    
    enum CodingKeys : String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password
        case phoneNumber = "phone_number"
        case birthday
        case totalPoints = "total_points"
        //Foreign Keys
        case gender
        case fitnessExp = "fitness_exp"
        case workoutIntensity = "workout_intensity"
        case workoutTypes = "workout_types"
    }
    
    
    init(email: String?, password: String?, phoneNumber: String?, birthday: String?, totalPoints: Int?, gender: String?, fitnessExp: String?, workoutIntensity: String?, workoutTypes: [String]? ) {
//        self.id = nil
//        self.firstName = nil
//        self.lastName = nil
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.birthday = birthday
        self.totalPoints = totalPoints
        //Foreign Keys
        self.gender = gender
        self.fitnessExp = fitnessExp
        self.workoutIntensity = workoutIntensity
        self.workoutTypes = workoutTypes
    }

    
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
    

}


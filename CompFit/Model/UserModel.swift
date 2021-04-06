//
//  UserModel.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 1/23/21.
//

import UIKit


class UserModel: Codable {
    var id: Int? = 0
    var firstName: String? = ""
    var lastName: String? = ""
    var email: String?
    var password: String?
    var phoneNumber: String?
    var birthday: String?
    var totalPoints: Int?
    var userDesc: String?
    var profilePicture: URL?
    var profilePictureData: String?
//    var profilePicture: URL
    var profilePictureImage: UIImage?
    
    //Foreign Keys
    var gender: String?
    var fitnessExp: String?
    var workoutIntensity: String?
    var workoutTypes: [String]?
    

    //only include keys you want to send to backend
    enum CodingKeys : String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password
        case phoneNumber = "phone_number"
        case birthday
        case totalPoints = "total_points"
        case userDesc = "user_description"
        case profilePicture = "profile_picture"
        case profilePictureData = "profile_picture_data"
        
        //Foreign Keys
        case gender = "gender_desc"
        case fitnessExp = "fitness_exp_title"
        case workoutIntensity = "workout_intensity_title"
        case workoutTypes = "workout_types"
    }
    
    
    
    init(email: String?, password: String?, phoneNumber: String?, birthday: String?, totalPoints: Int?, gender: String?, fitnessExp: String?, workoutIntensity: String?, workoutTypes: [String]? ) {
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.birthday = birthday
        self.totalPoints = totalPoints
        self.userDesc = ""
        //Foreign Keys
        self.gender = gender
        self.fitnessExp = fitnessExp
        self.workoutIntensity = workoutIntensity
        self.workoutTypes = workoutTypes
    }
    
    init(id: Int?, email: String?, password: String?, phoneNumber: String?, birthday: String?, totalPoints: Int?, gender: String?, fitnessExp: String?, workoutIntensity: String?, workoutTypes: [String]? ) {
        self.id = id
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.birthday = birthday
        self.totalPoints = totalPoints
        self.userDesc = ""
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
    
    
        
    
    func printUserModel() {
        var returnStr = "\n--- User Model Data ---\n"
    
        returnStr += "ID: "
        if self.id == nil {
            returnStr += "NA\n"
        } else {
            returnStr += String(self.id!) + "\n"
        }
        returnStr += "First Name: " + (self.firstName ?? "NA") + "\n"
        returnStr += "Last Name: " + (self.lastName ?? "NA") + "\n"
        returnStr += "Email: " + (self.email ?? "NA") + "\n"
        returnStr += "Password: " + (self.password ?? "NA") + "\n"
        returnStr += "User Description: " + (self.userDesc ?? "NA") + "\n"
        returnStr += "Phone Number: " + (self.phoneNumber ?? "NA") + "\n"
        returnStr += "Birthday: " + (self.birthday ?? "NA") + "\n"
        returnStr += "Total Points: "
        if self.totalPoints == nil {
            returnStr += "NA\n"
        } else {
            returnStr += String(self.totalPoints!) + "\n"
        }
        returnStr += "Profile Picture: " + (self.profilePicture?.absoluteString ?? "NA") + "\n"
        
    
        //Foreign Keys
        returnStr += "Gender: " + (self.gender ?? "NA") + "\n"
        returnStr += "Fitness Experience: " + (self.fitnessExp ?? "NA") + "\n"
        returnStr += "Birthday: " + (self.workoutIntensity ?? "NA") + "\n"
        if self.workoutTypes == nil {
            returnStr += "Workout Types: [None]\n"
        } else {
            returnStr += "Workout Types: ["
            for type in self.workoutTypes! {
                returnStr += type + ",  "
            }
            returnStr += "]\n"
        }
        
        returnStr += "\n\n"
        print(returnStr)
    }
    
    
}


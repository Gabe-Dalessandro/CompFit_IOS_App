//
//  Constants.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/7/21.
//

import UIKit

struct Constants {
    
    //Current User and its data
    static let currentUser = UserDefaults.standard.getCurrentUser()
    
    
    //Spacing and Constraints
    static let leadingInLets: Float = 17.0
    static let trailingInLets: Float = -17.0
    
    
    
    
    //Colors
    static let deepOrange = UIColor(red: 255.0/255.0, green: 106.0/255.0, blue: 0.01, alpha: 1)
    
    struct Colors {
        static let brandPink = UIColor(red: 227.0/255.0, green: 26.0/255.0, blue: 119.0/255.0, alpha: 1)
        static let brandBlue = UIColor(red: 19.0/255.0, green: 134.0/255.0, blue: 194.0/255.0, alpha: 1)
        static let brandGreen = UIColor(red: 215.0/255.0, green: 226.0/255.0, blue: 0.0/255.0, alpha: 1)
        static let brandLightGrey = UIColor(red: 49.0/255.0, green: 50.0/255.0, blue: 53.0/255.0, alpha: 1)
        static let brandDarkGrey = UIColor(red: 34.0/255.0, green: 35.0/255.0, blue: 38.0/255.0, alpha: 1)
        static let brandElectricGreen = UIColor(red: 216.0/255.0, green: 226.0/255.0, blue: 4.0/255.0, alpha: 1)
        
        static var pink_blue_Gradient: CAGradientLayer {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [Constants.Colors.brandBlue.cgColor, Constants.Colors.brandPink.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            
            return gradientLayer
        }
        

    }

}



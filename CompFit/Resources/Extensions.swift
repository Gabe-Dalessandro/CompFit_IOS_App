//
//  Extensions.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/30/21.
//

import Foundation
import UIKit
import HealthKit




extension UIFont {
    static func poppinsLight(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Light", size: size)
    }
    
    static func poppinsMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Medium", size: size)
    }
    
    static func poppinsRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Regular", size: size)
    }
    
    static func poppinsBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Bold", size: size)
    }
}

extension UIView {
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.origin.y + height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        frame.origin.x + width
    }
    
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
}

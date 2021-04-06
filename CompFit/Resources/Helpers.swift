//
//  Helpers.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 4/4/21.
//

import Foundation
import UIKit
import HealthKit


class Helpers {
    static public func getHKWorkoutTypeString(type: HKWorkoutActivityType) -> String {
        switch type {
        case .traditionalStrengthTraining:
            return "Strength Training"
        case .walking:
            return "Walk"
        case .running:
            return "Run"
        default:
            return "Not sure"
        }
    }
}

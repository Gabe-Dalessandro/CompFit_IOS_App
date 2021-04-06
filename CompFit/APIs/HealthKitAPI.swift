//
//  HealthKitAPI.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 3/20/21.
//

import Foundation
import UIKit
import HealthKit

var healthStore: HKHealthStore? = HKHealthStore.isHealthDataAvailable() ? HKHealthStore() : nil



class HealthKit {
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
    
    
    // Query workouts
    static public func getPastWorkouts() {
        print("=== Getting Most Recent Workouts ===")
        
        let workoutType = HKObjectType.workoutType()
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        //1. Get workouts that are for "Strength Training"
        // let workoutPredicate = HKQuery.predicateForWorkouts(with: .traditionalStrengthTraining)
        
        //2. Construct the query
        let workoutQuery = HKSampleQuery(sampleType: workoutType,
                                         predicate: nil,
                                         limit: 7,
                                         sortDescriptors: [sort]) {
            query, samples, error in
            
            //4. Runs when query completes
            DispatchQueue.main.async {
                guard let samples = samples as? [HKWorkout], //returns HKSamples by default
                error == nil
                else {
                    print("error getting the workouts")
                    return
                }
                
                //5.  Print the attributes of each workout to the terminal
                var day = 1
                for x in samples {
                    // duration of workout
                    let minutes = x.endDate.timeIntervalSince(x.startDate)/60
                    let timeElapsed = Double(round(minutes*100)/100)
                    
                    // date the workout was completed
                    let date = x.startDate
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM dd, yyyy"
                    let dateStr = dateFormatter.string(from: date)
                    
                    // calories for that workout
                    let calories = x.totalEnergyBurned?.doubleValue(for: .kilocalorie())
                    
                    // Print the workout data
                    if calories != nil {
                        print("Workout \(day): \(dateStr)")
                        print("Type: \(Helpers.getHKWorkoutTypeString(type: x.workoutActivityType))")
                        print("Total Time: \(timeElapsed) mins")
                        print("Calories: \(Int(calories!))\n")
                        day += 1
                    } else {
                        print("Workout \(day): \(timeElapsed)")
                        print(calories ?? 0)
                    }
                }
            }
        }
        
        //3. Execute the query
        healthStore?.execute(workoutQuery)
    }
    
    

    
}



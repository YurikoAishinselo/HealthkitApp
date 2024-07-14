//
//  HealthManager.swift
//  healthkitApp
//
//  Created by Yuriko AIshinselo on 24/04/24.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject{
    let healthStore = HKHealthStore()
    
    init(){
        let steps = HKQuantityType(.stepCount)
        let HealthType: Set = [steps]
        
        Task{
            do{
                try await healthStore.requestAuthorization(toShare: [], read: HealthType)
            } catch{
                print("Error fetching Healthkit data")
            }
        }
    }
}

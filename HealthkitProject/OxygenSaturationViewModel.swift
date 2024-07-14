//
//  OxygenSaturationViewModel.swift
//  HealthkitProject
//
//  Created by Yuriko AIshinselo on 26/06/24.
//

import Foundation
class OxygenSaturationViewModel: ObservableObject{
//    private var healthManager: HealthkitManager
//    @Published var oxygenSaturationSample: [HKQuantitySample] = []
//    @Published var selectedDate: Date = Date()
//    
//    init() {
//        self.healthManager = HealthkitManager()
//        fetchHeartRateData(for: selectedDate)
//    }
//    
//    func fetchOxygenSaturation(for date: Date) {
//        let calendar = Calendar.current
//        let startDate = calendar.startOfDay(for: date)
//        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate) ?? date
//        
//        
//        healthManager.fetchOxygenSaturationData(startDate: <#T##Date#>, endDate: <#T##Date#>){ samples in
//            DispatchQueue.main.async {
//                self.oxygenSaturationSample = samples ?? []
//            }
//        }
//    }
//    
//    func requestHeartRateAuthorization() {
//        healthManager.requestOxygenSaturationAuthorization{ success in
//            if success {
//                self.fetchOxygenSaturation(for: self.selectedDate)
//            } else {
//                DispatchQueue.main.async {
//                    self.oxygenSaturation = []
//                    self.averageHeartRate = 0.0 // Set a default value on failure
//                }
//                print("Authorization failed")
//            }
//        }
//    }
//
//    func formattedHeartRate(for index: Int) -> String {
//        guard index < heartRateSamples.count else { return "" }
//        let sample = heartRateSamples[index]
//        let heartRateValue = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
//        return String(format: "%.0f BPM", heartRateValue)
//    }
}

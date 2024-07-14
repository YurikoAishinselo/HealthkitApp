import Foundation
import HealthKit

class HealthkitManager {
    var healthStore: HKHealthStore?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestHeartRateAuthorization(completion: @escaping (Bool) -> Void) {
        guard let healthStore = healthStore else {
            completion(false)
            return
        }
        
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
            HKObjectType.quantityType(forIdentifier: .walkingHeartRateAverage)!,
            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if let error = error {
                print("Error requesting HealthKit authorization: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(success)
            }
        }
    }
    
    func fetchHeartRateData(startDate: Date, endDate: Date, completion: @escaping ([HKQuantitySample]?) -> Void) {
        fetchSamples(type: .heartRate, startDate: startDate, endDate: endDate, completion: completion)
    }
    
    func fetchRestingHeartRateData(startDate: Date, endDate: Date, completion: @escaping ([HKQuantitySample]?) -> Void) {
        fetchSamples(type: .restingHeartRate, startDate: startDate, endDate: endDate, completion: completion)
    }
    
    func fetchWalkingHeartRateData(startDate: Date, endDate: Date, completion: @escaping ([HKQuantitySample]?) -> Void) {
        fetchSamples(type: .walkingHeartRateAverage, startDate: startDate, endDate: endDate, completion: completion)
    }
    
    func fetchHeartRateVariability(startDate: Date, endDate: Date, completion: @escaping ([HKQuantitySample]?) -> Void) {
        fetchSamples(type: .heartRateVariabilitySDNN, startDate: startDate, endDate: endDate, completion: completion)
    }
    
    private func fetchSamples(type: HKQuantityTypeIdentifier, startDate: Date, endDate: Date, completion: @escaping ([HKQuantitySample]?) -> Void) {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: type), let healthStore = healthStore else {
            completion(nil)
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: quantityType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { query, samples, error in
            if let error = error {
                print("Error fetching \(type) samples: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            completion(samples as? [HKQuantitySample])
        }
        
        healthStore.execute(query)
    }
}

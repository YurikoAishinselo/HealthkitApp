import Foundation
import HealthKit

class HeartViewModel: ObservableObject {
    private let healthManager = HealthkitManager()
    
    @Published var latestHeartRate: Double = 0.0
    @Published var latestHeartRateDate: String = "N/A"
    @Published var averageHeartRate: Double = 0.0
    @Published var restingHeartRate: Double = 0.0
    @Published var walkingHeartRate: Double = 0.0
    @Published var heartRateVariability: Double = 0.0
    
    init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        healthManager.requestHeartRateAuthorization { success in
            if success {
                print("HealthKit authorization granted.")
                self.fetchAllHeartRateData()
            } else {
                print("HealthKit authorization denied.")
            }
        }
    }
    
    func fetchAllHeartRateData() {
        fetchLatestHeartRate()
        fetchAverageHeartRate()
        fetchRestingHeartRate()
        fetchWalkingHeartRate()
        fetchHeartRateVariability()
    }
    
    func fetchLatestHeartRate() {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .year, value: -1, to: endDate)! // Look back up to 1 year
        
        healthManager.fetchHeartRateData(startDate: startDate, endDate: endDate) { samples in
            if let sample = samples?.first {
                DispatchQueue.main.async {
                    self.latestHeartRate = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                    self.latestHeartRateDate = self.formattedDate(from: sample.startDate)
                }
            } else {
                print("No heart rate data available within the last year.")
            }
        }
    }
    
    
    func fetchAverageHeartRate() {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        
        healthManager.fetchHeartRateData(startDate: startDate, endDate: endDate) { samples in
            if let samples = samples, !samples.isEmpty {
                let totalHeartRate = samples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())) }
                DispatchQueue.main.async {
                    self.averageHeartRate = totalHeartRate / Double(samples.count)
                }
            } else {
                print("No heart rate data available for averaging.")
            }
        }
    }
    
    func fetchRestingHeartRate() {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        
        healthManager.fetchRestingHeartRateData(startDate: startDate, endDate: endDate) { samples in
            if let sample = samples?.first {
                DispatchQueue.main.async {
                    self.restingHeartRate = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                }
            } else {
                print("No resting heart rate data available.")
            }
        }
    }
    
    func fetchWalkingHeartRate() {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        
        healthManager.fetchWalkingHeartRateData(startDate: startDate, endDate: endDate) { samples in
            if let sample = samples?.first {
                DispatchQueue.main.async {
                    self.walkingHeartRate = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                }
            } else {
                print("No walking heart rate data available.")
            }
        }
    }
    
    func fetchHeartRateVariability() {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        
        healthManager.fetchHeartRateVariability(startDate: startDate, endDate: endDate) { samples in
            if let sample = samples?.first {
                DispatchQueue.main.async {
                    self.heartRateVariability = sample.quantity.doubleValue(for: HKUnit.secondUnit(with: .milli))
                }
            } else {
                print("No heart rate variability data available.")
            }
        }
    }
    
    private func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: date)
    }
}

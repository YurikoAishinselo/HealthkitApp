import SwiftUI

struct HeartView: View {
    @StateObject var viewModel = HeartViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                latestHeartRateView
                heartRateInfoView(title: "Average Heart Rate", value: viewModel.averageHeartRate, unit: "BPM", imageName: "chart.bar.xaxis.ascending")
                heartRateInfoView(title: "Resting Heart Rate", value: viewModel.restingHeartRate, unit: "BPM", imageName: "figure.seated.side")
                heartRateInfoView(title: "Heart Rate Variability", value: viewModel.heartRateVariability, unit: "ms", imageName: "waveform.path")
                heartRateInfoView(title: "Walking Heart Rate", value: viewModel.walkingHeartRate, unit: "BPM", imageName: "figure.walk")
            }
            .padding()
        }
        .onAppear {
            viewModel.requestAuthorization()
        }
        .refreshable {
            viewModel.fetchAllHeartRateData()
        }
    }
    
    private var latestHeartRateView: some View {
        VStack {
            Image(systemName: "heart.fill")
                .font(.system(size: 100))
                .foregroundColor(.red)
                .padding(.bottom, 10)
            Text("Latest: \(viewModel.latestHeartRateDate)")
                .font(.title2)
            Text(viewModel.latestHeartRate > 0 ? "\(Int(viewModel.latestHeartRate)) BPM" : "N/A")
                .font(.largeTitle)
                .bold()
        }
    }
    
    private func heartRateInfoView(title: String, value: Double, unit: String, imageName: String) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(value > 0 ? String(format: "%.1f %@", value, unit) : "N/A")
                    .font(.title2)
                    .bold()
            }
            Spacer()
            Image(systemName: imageName)
                .font(.system(size: 30))
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    HeartView()
}
        

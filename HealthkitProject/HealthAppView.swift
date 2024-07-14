import SwiftUI

struct HealthAppView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    NavigationLink(destination: HeartView()) {
                        HealthCategoryView(categoryName: "Heart", imageName: "heart.fill", color: .red)
                    }
                    HealthCategoryView(categoryName: "Steps", imageName: "figure.walk", color: .green)
                    HealthCategoryView(categoryName: "Sleep", imageName: "bed.double.fill", color: .blue)
                    HealthCategoryView(categoryName: "Nutrition", imageName: "fork.knife", color: .orange)
                    HealthCategoryView(categoryName: "Mindfulness", imageName: "brain.head.profile", color: .purple)
                }
                .padding()
            }
            .navigationTitle("Health")
        }
    }
}

#Preview{
    HealthAppView()
}

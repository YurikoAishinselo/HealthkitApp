//
//  HealthCategoryView.swift
//  HealthkitProject
//
//  Created by Yuriko AIshinselo on 14/07/24.
//

import SwiftUI

struct HealthCategoryView: View {
    let categoryName: String
    let imageName: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(color)
                .frame(width: 60, height: 40)
            
            Text(categoryName)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    HealthCategoryView(categoryName: "Heart", imageName: "heart.fill", color: .red)
}

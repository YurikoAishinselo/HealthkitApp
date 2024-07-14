//
//  healthkitAppApp.swift
//  healthkitApp
//
//  Created by Yuriko AIshinselo on 24/04/24.
//

import SwiftUI

@main
struct healthkitAppApp: App {
   @StateObject var manager = HealthManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    
   
    
    
}

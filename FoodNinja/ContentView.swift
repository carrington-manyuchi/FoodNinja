//
//  ContentView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct ContentView: View {
    @State private var endSplash = true
    
    var body: some View {
        NavigationStack {            
            if endSplash {
                SplashView()
            } else {
                OnboardingView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                endSplash = false
            }
        }
        
    }
}

#Preview {
    ContentView()
}

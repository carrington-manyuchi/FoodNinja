//
//  ContentView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

//struct ContentView: View {
//    @StateObject private var authViewModel = AuthViewModel()
//    @ObservedObject private var appState = AppState()
//    @State private var endSplash = true
//    
//    var body: some View {
//        NavigationStack {            
//            if endSplash {
//                SplashView()
//            } else if appState.isOnboardingDone {
//                Text("Login")
//            } else {
//                OnboardingView()
//                    .environmentObject(appState)
//            }
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                endSplash = false
//            }
//        }
//        
//    }
//}
//
#Preview {
    ContentView()
}

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var endSplash = true
    
    var body: some View {
        Group {
            if endSplash {
                SplashView()
            } else {
                if authViewModel.isAuthenticated {
                    HomeTabView()
                } else {
                    OnboardingView()
                        .environmentObject(authViewModel)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                endSplash = false
            }
        }
    }
}

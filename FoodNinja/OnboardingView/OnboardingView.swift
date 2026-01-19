//
//  OnboardingView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject private var viewModel = OnboardingViewModel()
    @State private var showLogin = false
    @State private var currentPage = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // TabView for onboarding pages
                TabView(selection: $currentPage) {
                    ForEach(Array(viewModel.onboardingPages.enumerated()), id: \.offset) { index, page in
                        OnboardingContent(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // Get Started Button - Fixed NavigationLink
                VStack {
                    Spacer()
                    
                    // Option 1: Simple button that shows login view
                    if currentPage == (viewModel.onboardingPages.count - 1) {
                        Button {
                            showLogin = true
                        } label: {
                            CustomButton(config: CustomButtonConfig(
                                title: "GET STARTED",
                                action: {
                                    showLogin = true
                                },
                                titleColor: .white,
                                fontSize: 18
                            ))
                            .frame(width: 160)
                        }
                        .padding(.bottom, 50)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showLogin) {
                LoginView()
            }
        }
    }
}

#Preview {
    OnboardingView()
}

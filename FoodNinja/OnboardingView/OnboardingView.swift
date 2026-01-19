//
//  OnboardingView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject private var viewModel = OnboardingViewModel()

    
    var body: some View {
        ZStack {
            TabView {
                ForEach(Array(viewModel.onboardingPages.enumerated()), id: \.offset) { index, page in
                    OnboardingContent(page: page)
                }
            }
            .tabViewStyle(.page)
            
            let config = CustomButtonConfig(
                title: "NEXT") {
                    print("NEXT is tapped")
                }
            CustomButton(config: config)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .frame(width: 160)
                .padding(.bottom)
        }
    }
}

#Preview {
    OnboardingView()
}

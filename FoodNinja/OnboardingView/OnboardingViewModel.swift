//
//  OnboardingViewModel.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import Foundation
import SwiftUI
import Combine

final class OnboardingViewModel: ObservableObject {
    @Published var onboardingPages: [OnboardingPage]
    
    init() {
        onboardingPages = [
            OnboardingPage(
                imageName: .onboarding1,
                title: "Find your  Comfort Food here",
                description: "Here You Can find a chef or dish for every taste and color. Enjoy!"
            ),
            OnboardingPage(
                imageName: .onboarding2,
                title: "Food Ninja is Where Your Comfort Food Lives",
                description: "Enjoy a fast and smooth food delivery at your doorstep"
            )
        ]
    }
}




    
    

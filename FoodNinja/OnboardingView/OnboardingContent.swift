//
//  OnboardingPage.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct OnboardingPage {
    let imageName: ImageName
    let title: String
    let description: String
}

struct OnboardingContent: View {
    let page: OnboardingPage
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            Image(name: page.imageName)
                .resizable()
                .scaledToFit()
                .offset(y: isAnimating ? 45 : 0)
                .animation(
                    .easeInOut(duration: 5)
                    .repeatForever(autoreverses: true), value: isAnimating
                )
                .opacity(isAnimating ? 1 : 0)

            
            Text(page.title)
                .font(.system(size: 30, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.horizontal)
                .opacity(isAnimating ? 1 : 0)
            
            Text(page.description)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.horizontal)
                .opacity(isAnimating ? 1 : 0)

        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            withAnimation(.linear(duration: 2)) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    OnboardingContent(
        page: OnboardingPage(
            imageName: .onboarding1,
            title: "Food Ninja is Where Your Comfort Food Lives",
            description: "Enjoy a fast and smooth food delivery at your doorstep"
        )
    )
}

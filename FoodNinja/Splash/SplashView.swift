//
//  SplashView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image(name: .splash)
                .resizable()
                .ignoresSafeArea()
                .scaledToFit()
            
            
            Image(name: .splashLogo)
            
        }
    }
}

#Preview {
    SplashView()
}

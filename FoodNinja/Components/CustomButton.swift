//
//  CustomButton.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct CustomButtonConfig {
    let title: String
    let action: () -> Void
    var titleColor : Color = .white
    var fontSize: CGFloat = 16
}

struct CustomButton: View {
    let config: CustomButtonConfig
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 57)
                .background {
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .lightGreen, location: 0.0),
                            Gradient.Stop(color: .darkGreen, location: 1.0)
                        ],
                        startPoint: UnitPoint(x: 0, y: 0),
                        endPoint: UnitPoint(x: 1, y: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            
            Text(config.title)
                .font(.system(size: config.fontSize, weight: .bold))
                .foregroundStyle(config.titleColor)
            
        }
        .onTapGesture {
            config.action()
        }
        .padding()
    }
}

#Preview {
    CustomButton(config: .init(title: "test", action: {
        
    }, titleColor: .white, fontSize: 18))
}

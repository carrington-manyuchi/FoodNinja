//
//  AppState.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import Foundation
import SwiftUI
import Combine

enum AppStorageKey: String {
    case isOnboardingDone
}

final class AppState: ObservableObject {
    @AppStorage(AppStorageKey.isOnboardingDone.rawValue) var isOnboardingDone: Bool = false
    
}

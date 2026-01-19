//
//  AuthViewModel.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userDefaultsKey = "loggedInUser"
    
    init() {
        // Check if user is already logged in
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
            isAuthenticated = true
        }
    }
    
    func login(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            
            // Mock validation - in real app, validate with backend
            if !email.isEmpty && !password.isEmpty {
                let user = User(email: email, name: "User", password: password)
                self.currentUser = user
                self.isAuthenticated = true
                
                // Save user to UserDefaults
                if let data = try? JSONEncoder().encode(user) {
                    UserDefaults.standard.set(data, forKey: self.userDefaultsKey)
                }
            } else {
                self.errorMessage = "Invalid email or password"
            }
        }
    }
    
    func signup(name: String, email: String, password: String, confirmPassword: String) {
        isLoading = true
        errorMessage = nil
        
        // Validate passwords match
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            isLoading = false
            return
        }
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            
            // Mock validation
            if !name.isEmpty && !email.isEmpty && !password.isEmpty {
                let user = User(email: email, name: name, password: password)
                self.currentUser = user
                self.isAuthenticated = true
                
                // Save user to UserDefaults
                if let data = try? JSONEncoder().encode(user) {
                    UserDefaults.standard.set(data, forKey: self.userDefaultsKey)
                }
            } else {
                self.errorMessage = "Please fill all fields"
            }
        }
    }
    
    func logout() {
        currentUser = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}

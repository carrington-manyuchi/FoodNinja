//
//  HomeTabView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct HomeTabView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var selectedTab = 0
    
    init() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: ImageName.home.rawValue)
            }
            .tag(0)
            
            // Profile Tab
            NavigationStack {
                ProfileView(viewModel: authViewModel)
            }
            .tabItem {
                Label("Profile", systemImage: ImageName.profile.rawValue)
            }
            .tag(1)
            
            // Settings Tab
            NavigationStack {
                SettingsView(viewModel: authViewModel)
            }
            .tabItem {
                Label("Settings", systemImage: ImageName.settings.rawValue)
            }
            .tag(2)
            
            // More Tab
            NavigationStack {
                MoreView(viewModel: authViewModel)
            }
            .tabItem {
                Label("More", systemImage: ImageName.more.rawValue)
            }
            .tag(3)
        }
        .accentColor(.darkGreen)
    }
}

// Home View
struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back,")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        Text("Food Ninja")
                            .font(.system(size: 28, weight: .bold))
                    }
                    
                    Spacer()
                    
                    // Notification Bell
                    Button {
                        // Show notifications
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray6))
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "bell.fill")
                                .foregroundColor(.darkGreen)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search food, restaurants", text: .constant(""))
                        .font(.system(size: 16))
                    
                    Spacer()
                    
                    Button {
                        // Filter
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.darkGreen)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // Featured Restaurants
                VStack(alignment: .leading, spacing: 16) {
                    Text("Featured Restaurants")
                        .font(.system(size: 20, weight: .semibold))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<5) { _ in
                                RestaurantCard()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Popular Items
                VStack(alignment: .leading, spacing: 16) {
                    Text("Popular Items")
                        .font(.system(size: 20, weight: .semibold))
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(0..<6) { _ in
                            FoodItemCard()
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
    }
}

struct RestaurantCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Restaurant Image
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray5))
                .frame(width: 200, height: 120)
                .overlay(
                    Image(systemName: "fork.knife")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
            
            // Restaurant Info
            VStack(alignment: .leading, spacing: 4) {
                Text("Restaurant Name")
                    .font(.system(size: 16, weight: .semibold))
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.orange)
                    
                    Text("4.5")
                        .font(.system(size: 14))
                    
                    Text("•")
                        .foregroundColor(.gray)
                    
                    Text("15-20 min")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(width: 200)
    }
}

struct FoodItemCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Food Image
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray5))
                .frame(height: 120)
                .overlay(
                    Image(systemName: "takeoutbag.and.cup.and.straw")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
            
            // Food Info
            VStack(alignment: .leading, spacing: 4) {
                Text("Food Item")
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                
                Text("Delicious description here")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Text("$12.99")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.darkGreen)
                    
                    Spacer()
                    
                    Button {
                        // Add to cart
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.darkGreen)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

// Profile View
struct ProfileView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Header
                VStack(spacing: 16) {
                    // Profile Image
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 100, height: 100)
                        
                        Image(sysNameImage: .profile)
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                    }
                    
                    // User Info
                    VStack(spacing: 4) {
                        Text(viewModel.currentUser?.name ?? "User Name")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Text(viewModel.currentUser?.email ?? "user@example.com")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    // Edit Profile Button
                    Button {
                        // Edit profile
                    } label: {
                        Text("Edit Profile")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.darkGreen)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .stroke(Color.darkGreen, lineWidth: 1)
                            )
                    }
                }
                .padding(.top, 40)
                
                // Menu Items
                VStack(spacing: 0) {
                    ProfileMenuItem(icon: "person.fill", title: "Personal Information")
                    ProfileMenuItem(icon: "creditcard.fill", title: "Payment Methods")
                    ProfileMenuItem(icon: "location.fill", title: "My Addresses")
                    ProfileMenuItem(icon: "heart.fill", title: "Favorites")
                    ProfileMenuItem(icon: "clock.fill", title: "Order History")
                    ProfileMenuItem(icon: "tag.fill", title: "Promo Codes")
                    ProfileMenuItem(icon: "questionmark.circle.fill", title: "Help Center")
                }
                .background(Color(.systemBackground))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // Logout Button
                Button {
                    viewModel.logout()
                } label: {
                    Text("Logout")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.red)
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileMenuItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.darkGreen)
                .frame(width: 30)
            
            Text(title)
                .font(.system(size: 16))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            Divider()
                .padding(.leading, 50),
            alignment: .bottom
        )
    }
}

// Settings View
struct SettingsView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    
    var body: some View {
        List {
            Section("Preferences") {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                Toggle("Dark Mode", isOn: $darkModeEnabled)
            }
            
            Section("Privacy") {
                NavigationLink("Privacy Policy") {
                    Text("Privacy Policy")
                        .navigationTitle("Privacy Policy")
                }
                
                NavigationLink("Terms of Service") {
                    Text("Terms of Service")
                        .navigationTitle("Terms of Service")
                }
                
                NavigationLink("Data Usage") {
                    Text("Data Usage")
                        .navigationTitle("Data Usage")
                }
            }
            
            Section("About") {
                NavigationLink("About Us") {
                    Text("About Us")
                        .navigationTitle("About Us")
                }
                
                NavigationLink("Version") {
                    Text("Version 1.0.0")
                        .navigationTitle("App Version")
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// More View
struct MoreView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        List {
            Section {
                NavigationLink("Invite Friends") {
                    Text("Invite Friends")
                        .navigationTitle("Invite Friends")
                }
                
                NavigationLink("Rate Us") {
                    Text("Rate Us")
                        .navigationTitle("Rate Our App")
                }
                
                NavigationLink("Share App") {
                    Text("Share App")
                        .navigationTitle("Share App")
                }
            }
            
            Section("Support") {
                NavigationLink("Contact Us") {
                    Text("Contact Us")
                        .navigationTitle("Contact Us")
                }
                
                NavigationLink("FAQ") {
                    Text("Frequently Asked Questions")
                        .navigationTitle("FAQ")
                }
                
                NavigationLink("Report a Problem") {
                    Text("Report a Problem")
                        .navigationTitle("Report a Problem")
                }
            }
            
            Section {
                Button("Logout") {
                    viewModel.logout()
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("More")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeTabView()
}

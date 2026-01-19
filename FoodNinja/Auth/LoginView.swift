//
//  LoginView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 16) {
                        Image(name: .splashLogo)
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                        Text("Welcome Back!")
                            .font(.system(size: 28, weight: .bold))
                        
                        Text("Sign in to continue")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 40)
                    
                    // Form
                    VStack(spacing: 20) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(sysNameImage: .email)
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                
                                TextField("Enter your email", text: $email)
                                    .textContentType(.emailAddress)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .focused($focusedField, equals: .email)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(sysNameImage: .password)
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                
                                if showPassword {
                                    TextField("Enter your password", text: $password)
                                        .textContentType(.password)
                                        .focused($focusedField, equals: .password)
                                } else {
                                    SecureField("Enter your password", text: $password)
                                        .textContentType(.password)
                                        .focused($focusedField, equals: .password)
                                }
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(sysNameImage: showPassword ? .eyeSlash : .eye)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        // Forgot Password
                        HStack {
                            Spacer()
                            
                            NavigationLink("Forgot Password?") {
                                ForgotPasswordView()
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.darkGreen)
                        }
                        
                        // Error Message
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }
                        
                        // Login Button
                        Button {
                            viewModel.login(email: email, password: password)
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text("Login")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .lightGreen, location: 0.0),
                                    Gradient.Stop(color: .darkGreen, location: 1.0)
                                ],
                                startPoint: UnitPoint(x: 0, y: 0),
                                endPoint: UnitPoint(x: 1, y: 1)
                            )
                        )
                        .cornerRadius(15)
                        .disabled(viewModel.isLoading || email.isEmpty || password.isEmpty)
                        .opacity((viewModel.isLoading || email.isEmpty || password.isEmpty) ? 0.6 : 1)
                        .padding(.top, 8)
                        
                        // Sign Up Link
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
                            
                            NavigationLink("Sign Up") {
                                SignupView()
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.darkGreen)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Social Login
                    VStack(spacing: 16) {
                        Text("Or sign in with")
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 24) {
                            SocialLoginButton(image: .facebook, text: "Facebook")
                            SocialLoginButton(image: .google, text: "Google")
                        }
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
            .onTapGesture {
                focusedField = nil
            }
        }
    }
}

struct SocialLoginButton: View {
    let image: ImageName
    let text: String
    
    var body: some View {
        Button {
            // Handle social login
        } label: {
            HStack(spacing: 8) {
                Image(name: image)
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(text)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

struct ForgotPasswordView: View {
    @State private var email = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Forgot Password")
                .font(.system(size: 28, weight: .bold))
            
            Text("Enter your email address and we'll send you instructions to reset your password.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                TextField("Enter your email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Button {
                // Send reset instructions
                dismiss()
            } label: {
                Text("Send Instructions")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .lightGreen, location: 0.0),
                        Gradient.Stop(color: .darkGreen, location: 1.0)
                    ],
                    startPoint: UnitPoint(x: 0, y: 0),
                    endPoint: UnitPoint(x: 1, y: 1)
                )
            )
            .cornerRadius(15)
            .disabled(email.isEmpty)
            .opacity(email.isEmpty ? 0.6 : 1)
            
            Spacer()
        }
        .padding(.top, 40)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LoginView()
}

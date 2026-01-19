//
//  SignupView.swift
//  FoodNinja
//
//  Created by Manyuchi, Carrington C on 2026/01/19.
//
import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, email, password, confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 16) {
                            Image(name: .splashLogo)
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                            Text("Create Account")
                                .font(.system(size: 28, weight: .bold))
                            
                            Text("Fill your information below or register with your social account")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 20)
                        
                        // Form
                        VStack(spacing: 20) {
                            // Name Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Name")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    Image(sysNameImage: .person)
                                        .foregroundColor(.gray)
                                        .frame(width: 20)
                                    
                                    TextField("Enter your name", text: $name)
                                        .textContentType(.name)
                                        .focused($focusedField, equals: .name)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            
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
                                            .textContentType(.newPassword)
                                            .focused($focusedField, equals: .password)
                                    } else {
                                        SecureField("Enter your password", text: $password)
                                            .textContentType(.newPassword)
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
                            
                            // Confirm Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Confirm Password")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                HStack {
                                    Image(sysNameImage: .password)
                                        .foregroundColor(.gray)
                                        .frame(width: 20)
                                    
                                    if showConfirmPassword {
                                        TextField("Confirm your password", text: $confirmPassword)
                                            .textContentType(.newPassword)
                                            .focused($focusedField, equals: .confirmPassword)
                                    } else {
                                        SecureField("Confirm your password", text: $confirmPassword)
                                            .textContentType(.newPassword)
                                            .focused($focusedField, equals: .confirmPassword)
                                    }
                                    
                                    Button {
                                        showConfirmPassword.toggle()
                                    } label: {
                                        Image(sysNameImage: showConfirmPassword ? .eyeSlash : .eye)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            
                            // Error Message
                            if let error = viewModel.errorMessage {
                                Text(error)
                                    .font(.system(size: 14))
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                            }
                            
                            // Terms & Conditions
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.square")
                                    .foregroundColor(.darkGreen)
                                
                                Text("I agree with Terms of Service and Privacy Policy")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                            
                            // Sign Up Button
                            Button {
                                viewModel.signup(
                                    name: name,
                                    email: email,
                                    password: password,
                                    confirmPassword: confirmPassword
                                )
                            } label: {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text("Sign Up")
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
                            .disabled(viewModel.isLoading || name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
                            .opacity((viewModel.isLoading || name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) ? 0.6 : 1)
                            
                            // Login Link
                            HStack {
                                Text("Already have an account?")
                                    .foregroundColor(.gray)
                                
                                NavigationLink("Login") {
                                    LoginView()
                                }
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.darkGreen)
                            }
                            .padding(.top, 20)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        // Social Signup
                        VStack(spacing: 16) {
                            Text("Or sign up with")
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 24) {
                                SocialLoginButton(image: .facebook, text: "Facebook")
                                SocialLoginButton(image: .google, text: "Google")
                            }
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
            .onTapGesture {
                focusedField = nil
            }
        }
    }
}

#Preview {
    SignupView()
}

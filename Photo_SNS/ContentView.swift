//
//  ContentView.swift
//  Photo_SNS
//
//  Created by 최명연 on 12/10/24.
//

import SwiftUI

// Identifiable을 준수하는 CustomAlertMessage 타입 정의
struct CustomAlertMessage: Identifiable {
    var id = UUID() // 고유 ID 필요
    var message: String
}

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var alertMessage: CustomAlertMessage?
    @State private var isSignupPresented: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

            Button(action: login) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Button(action: {
                            isSignupPresented = true
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.clear)
                        }
                        .sheet(isPresented: $isSignupPresented) {
                            SignupView()
                        }

            Spacer()
        }
        .padding()
        .alert(item: $alertMessage) { message in
            Alert(title: Text("Alert"), message: Text(message.message), dismissButton: .default(Text("OK")))
        }
    }

    func login() {
        if email.isEmpty || password.isEmpty {
            alertMessage = CustomAlertMessage(message: "Please enter both email and password.")
        } else if email == "test@example.com" && password == "password" {
            alertMessage = CustomAlertMessage(message: "Login Successful!")
        } else {
            alertMessage = CustomAlertMessage(message: "Invalid email or password.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


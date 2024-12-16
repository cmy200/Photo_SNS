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
    @State private var isLoginSuccessful: Bool = false // 로그인 성공 여부
    @State private var isSignupPresented: Bool = false // 회원가입 화면 표시 여부

    var body: some View {
        NavigationStack {
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

                // 로그인 버튼
                Button(action: login) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                // 회원가입 버튼
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
            .navigationDestination(isPresented: $isLoginSuccessful) {
                mainView() // 로그인 성공 시 이동할 메인 화면
            }
            .navigationBarHidden(true)
        }
    }

    func login() {
        if email.isEmpty || password.isEmpty {
            alertMessage = CustomAlertMessage(message: "Please enter both email and password.")
        } else if email == "admin123" && password == "admin1234" {
            isLoginSuccessful = true // 로그인 성공 시 화면 전환
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



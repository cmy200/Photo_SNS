//
//  SignupView.swift
//  Photo_SNS
//
//  Created by 최명연 on 12/10/24.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss // 현재 화면 닫기를 위한 dismiss 환경 변수
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedCamera: String = "None"
    @State private var cameras: [String] = ["None","Canon", "Nikon", "Sony", "Fujifilm", "Panasonic", "Other"]
    @State private var successMessage: String? // 성공 메시지
    @State private var showMessage: Bool = false // 메시지 표시 여부

    var body: some View {
        VStack(spacing: 20) {
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            // 아이디와 카메라 선택 드롭다운을 같은 줄에 배치
            HStack(spacing: 10) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                Picker("", selection: $selectedCamera) {
                    ForEach(cameras, id: \.self) { camera in
                        Text(camera).tag(camera)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }

            // 비밀번호 입력 필드
            SecureField("Password", text: $password)
                .padding()
                
                .background(Color(.systemGray6))
                .cornerRadius(8)

            // 회원가입 버튼
            Button(action: signUp) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

            Spacer()

            // 메시지 표시 영역
            if showMessage, let successMessage = successMessage {
                Text(successMessage)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.secondary)
                    .cornerRadius(8)
                    .transition(.opacity) // 메시지 전환 애니메이션
                    .animation(.easeInOut(duration: 0.3), value: showMessage)
            }
        }
        .padding()
    }

    func signUp() {
        if email.isEmpty || password.isEmpty || selectedCamera == "None" {
            // 입력이 비어 있으면 메시지 표시
            successMessage = "Please fill all fields."
        } else {
            // 성공 메시지 표시
            successMessage = "Sign Up Successful!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                dismiss() // 2초 후 화면 닫기
            }
        }

        // 메시지 표시 상태 업데이트
        showMessage = true

        // 메시지를 일정 시간 후 자동으로 숨김
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showMessage = false
        }
    }
}

#Preview {
    SignupView()
}

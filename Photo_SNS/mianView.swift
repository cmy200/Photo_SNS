//
//  mianView.swift
//  Photo_SNS
//
//  Created by 최명연 on 12/11/24.
//

import SwiftUI

struct Post: Identifiable {
    let id = UUID()
    let imageName: String // 이미지 파일 이름
    let title: String     // 게시글 제목
    let description: String // 게시글 설명
}

struct mainView: View {
    @State private var posts: [Post] = [
        Post(imageName: "photo1", title: "Vacation in Bali", description: "Beautiful sunset at the beach."),
        Post(imageName: "photo2", title: "Mountain Hike", description: "Reached the peak after a long hike."),
        Post(imageName: "photo3", title: "City Lights", description: "Night view of the bustling city.")
    ]

    @State private var isPresentingPostingView: Bool = false // 모달 표시 여부

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // 게시글 목록
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(posts) { post in
                            VStack(alignment: .leading, spacing: 10) {
                                // 게시글 이미지
                                Image(post.imageName)
                                    .resizable()
                                    .scaledToFit() // 원본 비율을 유지하며 화면에 맞게 표시
                                    .cornerRadius(10)
                                    .shadow(radius: 3)

                                // 게시글 제목 및 설명
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(post.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text(post.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal)

                                Divider()
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }

                Spacer()

                // 게시글 추가 버튼 (모달 표시)
                Button(action: {
                    isPresentingPostingView = true
                }) {
                    Text("Add Post")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .sheet(isPresented: $isPresentingPostingView) {
                    postingView { newPost in
                        posts.append(newPost) // 새 게시글 추가
                    }
                }

                // 하단 네비게이션 버튼
                HStack {
                    Spacer()

                    // 버튼 1 (MainView 비활성화)
                    Button(action: {}, label: {
                        VStack {
                            Image(systemName: "list.bullet")
                                .font(.largeTitle)
                            Text("Go to Main")
                                .font(.caption)
                        }
                    })
                    .disabled(true)
                    .foregroundColor(.gray)

                    Spacer()

                    // 버튼 2 (MapView로 이동)
                    NavigationLink(destination: mapView().navigationBarBackButtonHidden(true)) {
                        VStack {
                            Image(systemName: "map")
                                .font(.largeTitle)
                            Text("Go to Map")
                                .font(.caption)
                        }
                    }
                    Spacer()

                    // 버튼 3 (SettingView로 이동)
                    NavigationLink(destination: settingView().navigationBarBackButtonHidden(true)) {
                        VStack {
                            Image(systemName: "gearshape")
                                .font(.largeTitle)
                            Text("Go to Settings")
                                .font(.caption)
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .navigationTitle("Main View")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    mainView()
}

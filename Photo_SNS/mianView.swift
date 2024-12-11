//
//  mianView.swift
//  Photo_SNS
//
//  Created by 최명연 on 12/11/24.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        NavigationView {
            VStack {

                Spacer()

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
                    NavigationLink(destination: mapView()) {
                        VStack {
                            Image(systemName: "map")
                                .font(.largeTitle)
                            Text("Go to Map")
                                .font(.caption)
                        }
                    }
                    Spacer()

                    // 버튼 3 (SettingView로 이동)
                    NavigationLink(destination: settingView()) {
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
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    mainView()
}

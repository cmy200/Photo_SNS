//
//  mapView.swift
//  Photo_SNS
//
//  Created by 최명연 on 12/11/24.
//

import SwiftUI

struct mapView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()

                HStack {
                    Spacer()

                    // 버튼 1 (MainView로 이동)
                    NavigationLink(destination: mainView()) {
                        VStack {
                            Image(systemName: "list.bullet")
                                .font(.largeTitle)
                            Text("Go to Main")
                                .font(.caption)
                        }
                    }
                    Spacer()

                    // 버튼 2 (MapView 비활성화)
                    Button(action: {}, label: {
                        VStack {
                            Image(systemName: "map")
                                .font(.largeTitle)
                            Text("Go to Map")
                                .font(.caption)
                        }
                    })
                    .disabled(true)
                    .foregroundColor(.gray)

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
            .navigationTitle("Map View")
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    mapView()
}

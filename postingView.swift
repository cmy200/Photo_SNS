//
//  postingView.swift
//  Photo_SNS
//
//  Created by 최명연 on 12/16/24.
//

import SwiftUI
import PhotosUI

struct postingView: View {
    @Environment(\.dismiss) var dismiss // 모달 닫기
    @State private var image: UIImage? // 선택된 이미지
    @State private var title: String = "" // 게시글 제목
    @State private var description: String = "" // 게시글 설명
    @State private var isPickerPresented: Bool = false // 갤러리 표시 여부

    var onPostAdded: (Post) -> Void // 게시글 추가 콜백

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 이미지 미리보기 또는 버튼
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 3)
                } else {
                    Button(action: {
                        isPickerPresented = true
                    }) {
                        VStack {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Select a Photo")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }

                // 제목 입력
                TextField("Title", text: $title)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                // 설명 입력
                TextField("Description", text: $description)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                // 게시글 추가 버튼
                Button(action: {
                    if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
                        let imageName = UUID().uuidString // 고유 이미지 이름 생성
                        saveImageToDocuments(imageData: imageData, imageName: imageName)

                        let newPost = Post(imageName: imageName, title: title, description: description)
                        onPostAdded(newPost)
                        dismiss() // 모달 닫기
                    }
                }) {
                    Text("Post")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(image == nil || title.isEmpty || description.isEmpty) // 필수값 없으면 비활성화

                Spacer()
            }
            .padding()
            .navigationBarHidden(true) // 네비게이션 바 숨기기
            .sheet(isPresented: $isPickerPresented) {
                PhotoPicker(selectedImage: $image) // 갤러리에서 이미지 선택
            }
        }
    }

    // 문서 디렉토리에 이미지 저장
    private func saveImageToDocuments(imageData: Data, imageName: String) {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(imageName).jpg")
        do {
            try imageData.write(to: fileURL)
            print("Image saved at \(fileURL)")
        } catch {
            print("Error saving image: \(error)")
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images // 이미지만 선택 가능
        configuration.selectionLimit = 1 // 한 개의 이미지 선택

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self) else { return }

            provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                DispatchQueue.main.async {
                    self?.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}


#Preview {
    postingView(onPostAdded: { _ in
        // 미리보기에서 게시글 추가 동작을 테스트하지 않으므로 빈 클로저 제공
        print("Post added in preview")
    })
}

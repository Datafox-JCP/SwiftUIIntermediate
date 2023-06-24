//
//  PhotoPickerView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 19/06/23.
//

import SwiftUI
// 4
import PhotosUI

// 1
@MainActor
final class PhotoPickerViewModel: ObservableObject {
    
    @Published private(set) var selectedImage: UIImage? = nil
    // 6
//    @Published var imageSelection: PhotosPickerItem? = nil
    // 8
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            // 10
            setImage(from: imageSelection)
        }
    }
    
    // 11
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            // 13
            setImages(from: imageSelections)
        }
    }
    
    // 9
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
//            if let data = try? await selection.loadTransferable(type: Data.self) {
//                if let uiImage = UIImage(data: data) {
//                    selectedImage = uiImage
//                    return
//                }
//            }
            
            // 10 comentar la anterior y usar
            do {
                let data = try? await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badURL)
                }
                selectedImage = uiImage
            } catch {
                print(error)
            }
        }
    }
    
    // 12
    private func setImages(from selections: [PhotosPickerItem]) {
        Task {
            var images: [UIImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        images.append(uiImage)
                    }
                }
            }
            
            selectedImages = images
        }
    }
}

struct PhotoPickerView: View {
    
    // 2
    @StateObject private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, World!")
            
            // 3
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300, alignment: .center)
                    .cornerRadius(16)
            }
            
            // 5 dejar en selection y label y hacer el 6 y después poner $viewModel.imageSelection y completar
//            PhotosPicker(selection: $viewModel.imageSelection) {
            // 7
            PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                Text("Abrir selector de fotos")
                    .foregroundColor(.red)
            }
            
            // 14
            if !viewModel.selectedImages.isEmpty {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(viewModel.selectedImages, id:\.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50, alignment: .center)
                                .cornerRadius(16)
                        }
                    }
                }
            }
            
            PhotosPicker(selection: $viewModel.imageSelections, matching: .images) {
                Text("Abrir selector de fotos")
                    .foregroundColor(.red)
            }
        }
    }
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
    }
}

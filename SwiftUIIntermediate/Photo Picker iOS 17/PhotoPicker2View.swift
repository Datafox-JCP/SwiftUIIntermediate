//
//  PhotoPicker2View.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 31/10/23.
//

import SwiftUI
// 2
import PhotosUI
/// El picker debe estar asociado a otro elemento

struct PhotoPicker2View: View {
    
//    @State private var avatarImage: UIImage?
//    // 4
//    @State private var photosPickerItem: PhotosPickerItem?
    
    // 6
    @State private var images: [UIImage] = []
    @State private var photoPickerItems: [PhotosPickerItem] = []
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                // 3 el código de Image dentro de PhotosPicker
//                PhotosPicker(selection: $photosPickerItem, matching: .images) {
//                    Image(uiImage: avatarImage ?? UIImage(resource: .defaultAvatar))
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 100, height: 100)
//                        .clipShape(.circle)
//                }
//                
//                VStack(alignment: .leading) {
//                    Text("Juan Carlos Pazos")
//                        .font(.title.bold())
//
//                    Text("Desarrollador iOS")
//                        .font(.headline)
//                        .foregroundStyle(.secondary)
//                }
//                
//                Spacer()
                
                PhotosPicker("Seleccionar Fotos", selection: $photoPickerItems, maxSelectionCount: 5, selectionBehavior: .ordered)
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(0..<images.count, id:\.self) { i in
                            Image(uiImage: images[i])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(16)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        // 5
//        .onChange(of: photosPickerItem) { _, _ in
//            Task {
//                if let photosPickerItem,
//                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
//                    if let image = UIImage(data: data) {
//                        avatarImage = image
//                    }
//                }
//                
//                photosPickerItem = nil /// para no mantener las selecciones
//            }
//        }
        .onChange(of: photoPickerItems) { _, _ in
            Task {
                for item in photoPickerItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            images.append(image)
                        }
                    }
                }
                
                photoPickerItems.removeAll() /// para no mantener las selecciones
            }
        }

    }
}

#Preview {
    PhotoPicker2View()
}

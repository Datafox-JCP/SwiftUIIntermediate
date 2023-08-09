//
//  FileManagerView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 05/08/23.
//

import SwiftUI

/*
 
 Optimizing Your App’s Data for iCloud Backup
 https://developer.apple.com/documentation/foundation/optimizing_your_app_s_data_for_icloud_backup/
 
 File system Basics
 https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html
 */

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    let folderName = "App_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print ("Se creo el directorio")
            } catch let error {
                print ("Error creadon directorio \(error)")
            }
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard 
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error al obtener los datos"
        }
        
        do {
            try data.write(to: path)
            print(path)
            return "Imagen guardada correctamente"
        } catch let error {
            return "Error al guardar, \(error.localizedDescription)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error al obtener la ruta")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return "Error al obtener la ruta"
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Imagen eliminada"
        } catch let error {
            return "Error borrando imagen \(error)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else {
            print("Error al recuperar la ruta")
            return nil
        }
        
        return path
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print ("Directorio eliminado")
        } catch let error {
            print ("Error eliminando directorio \(error)")
        }
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var infoMessage = ""
    
    let imageName = "Imagen2"
    let manager = LocalFileManager.instance
    
    init() {
//        getImageFromAssetsFolder()
        getImageFromFileManager()
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
    }
    
    func deleteFolder() {
        manager.deleteFolder()
    }
}

struct FileManagerView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(10)
            }
            
            HStack {
                Button {
                    vm.saveImage()
                } label: {
                    Text("Guardar en FM")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                
                Button {
                    vm.deleteImage()
                } label: {
                    Text("Borrar de FM")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 32)
            
            Text(vm.infoMessage)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.purple)
            
            Spacer()
        }
        .navigationTitle("File Manager")
    }
}

struct FileManagerView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerView()
    }
}

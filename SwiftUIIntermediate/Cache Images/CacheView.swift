//
//  CacheView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 10/08/23.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Añadida al caché")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Eliminada al caché")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cacheImage: UIImage? = nil

    let imageName = "Imagen12"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cacheImage = manager.get(name: imageName)
    }
}

struct CacheView: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationStack {
            if let image = vm.startingImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(10)
            }
            
            HStack {
                Button {
                    vm.saveToCache()
                } label: {
                    Text("Guardar en caché")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                
                Button {
                    vm.removeFromCache()
                } label: {
                    Text("Borrar de caché")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Obtener de caché")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
            }
            .padding(.top, 32)
            
            if let image = vm.cacheImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(10)
            }
        }
        .navigationTitle("File Manager")
    }
}

struct CacheView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CacheView()
        }
    }
}

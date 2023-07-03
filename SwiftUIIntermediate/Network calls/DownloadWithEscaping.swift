//
//  DownloadWithEscaping.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 02/07/23.
//

import SwiftUI

/*
 HTTP response
     1 Informativas (100-199)
     2 Sucessful (200-299)
     3 Redirects (300-399)
     4 Error del cliente (400-499)
     5 Error del servidor (500-599)
 
 https://jsonplaceholder.typicode.com/posts/1
 https://app.quicktype.io
 */

// 6
// crear PostModel

// 1
class DownloadWithEscapingViewModel: ObservableObject {
    // 7
    @Published var posts: [PostModel] = []
    
    // 3
    init() {
        // 5
        getPosts()
    }
    
    // 4
    func getPosts() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        // 14 cambiar la llamada comentando la anterior
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        // 13
        downloadData(fromURL: url) { data in
            if let data {
//                guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
                // 15 cambiar a array para tomar todos y comentar la anterior
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    // 16
//                    self?.posts.append(newPost)
                    self?.posts = newPosts
                }
            } else {
                print("Sin datos")
            }
        }
        // una vez terminado la 13 remover todo lo de abajo

//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                print("Sin datos")
//                return
//            }
//
//            guard error == nil else {
//                print(("Error: \(String(describing: error))"))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print("Respuesta no válida")
//                return
//            }
//
//            guard response.statusCode >= 200 && response.statusCode < 300 else {
//                print("El código debe ser 2xx, pero es \(response.statusCode)")
//                return
//            }
            
            // 10 combinar los anteriores
//            guard
//                let data = data,
//                error == nil,
//                let response = response as? HTTPURLResponse,
//                response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Error descargando datos")
//                return
//            }
//
//            print("Se descargaron los datos")
//            print(data)
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString as Any)
//
//            // 8
//            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
//            // como se va a actualizar la UI
//            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(newPost)
//            }
//        }.resume()
    }
    
    // 12 esta es una función genérica
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error descargando datos")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }.resume()
    }
}

struct DownloadWithEscaping: View {
    // 2
    @StateObject private var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        // 9
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                } // VSTack
                .frame(maxWidth: .infinity, alignment: .leading)
            } // Loop
        } // List
    }
}

struct DownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscaping()
    }
}

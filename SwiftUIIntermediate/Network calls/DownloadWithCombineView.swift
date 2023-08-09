//
//  DownloadWithCombine.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 03/07/23.
//

import SwiftUI
// 14
import Combine

// Combine es para iOS 13 o superior

// 1
class DownloadWithCombineViewModel: ObservableObject {
    // 3
    @Published var posts: [PostModel] = []
    // 14
    var cancellables = Set<AnyCancellable>()
    // 5
    init() {
        getPosts()
    }
    
    // 6
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 7 crear Publiser
        URLSession.shared.dataTaskPublisher(for: url)
            // 8 Publisher on background es automático pero se pone
            .subscribe(on: DispatchQueue.global(qos: .background))
            // 9 recibir el el hilo principal
            .receive(on: DispatchQueue.main)
            // 10 tryMap para asegurarse que este bien
//            .tryMap { data, response -> Data in
//                guard let response = response as? HTTPURLResponse,
//                (200..<300) ~= response.statusCode else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            // 16 se comenta el tryMap y se llama la función
            .tryMap(handleOutput)
            // 11 decode
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            // 12 usar los datos con sync
            .sink { completion in
//                print("Completion: \(completion)") // para manejar errores
                switch completion {
                case .finished:
                    print("Completion: \(completion)")
                case .failure(let error):
                    print("Ocurrio un error \(error)")
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            // 13 cancelable
            .store(in: &cancellables)
    }
    
    // 15
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
        (200..<300) ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombineView: View {
    // 2
    @StateObject private var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        // 4
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

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineView()
    }
}

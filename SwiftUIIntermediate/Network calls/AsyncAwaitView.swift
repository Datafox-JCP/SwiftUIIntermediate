//
//  AsyncAwaitView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 20/06/23.
//

import SwiftUI

// 4
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

// 2 Crear el modelo
struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}

// 1 Lo que se va a mostrar
struct AsyncAwaitView: View {
    // 6
    // MARK: Propiedades
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack(spacing: 20) {
            // 10
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
                    // 11
//                    .frame(width: 120, height: 120)
            }
            .frame(width: 120, height: 120)
            
//            Text("Username")
            // 8
            Text(user?.login ?? "Id usuario")
                .bold()
                .font(.title)
            
//            Text("Aquí va un texto genérico que se lea desde el servidor")
            // 9
            Text(user?.bio ?? "Biografía")
            
            Spacer()
        } // VStack
        .padding()
        // 7
        .task {
            do {
                user = try await getUser()
            } catch NetworkError.invalidURL {
                print("URL no válida")
            } catch NetworkError.invalidData {
                print("Data no válida")
            } catch NetworkError.invalidResponse {
                print("Respuesta incorrecta")
            } catch {
                print("Error no identificado")
            }
        }
    }
    
    // MARK: Funciones
    // 3 hasta throw Error y crear el 4
    private func getUser() async throws -> GitHubUser {
        let endPoint = "https://api.github.com/users/Datafox-JCP"
        
        guard let url = URL(string: endPoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // 5
        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}

struct AsyncAwaitView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitView()
    }
}

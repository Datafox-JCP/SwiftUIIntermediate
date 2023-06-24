//
//  SearchWithAPICallView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 20/06/23.
//

import SwiftUI

struct SearchWithAPICallView: View {
    
    @State private var users: usersList = []
    @State private var searchUser = ""
    
    var filteredUsers: usersList {
        guard !searchUser.isEmpty else { return users }
        return users.filter { $0.name.localizedCaseInsensitiveContains(searchUser) }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredUsers, id:\.id) { user in
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(16)
                        .background(Color.gray)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.name)
                            .font(.title2)
                        Text(user.email)
                            .font(.title3)
                            .opacity(0.6)
                    }// VStack
                } // HStack
            } // List
            .listStyle(.plain)
            .task {
                do {
                    users = try await getUsers()
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
            .searchable(text: $searchUser, prompt: "Buscar usuario")
            .navigationTitle("Usuarios")
        }
    }
    
    private func getUsers() async throws -> usersList {
        let endPoint =  "https://jsonplaceholder.typicode.com/users"
        
        guard let url = URL(string: endPoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(usersList.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}

struct SearchWithAPICallView_Previews: PreviewProvider {
    static var previews: some View {
        SearchWithAPICallView()
    }
}

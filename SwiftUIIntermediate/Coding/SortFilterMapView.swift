//
//  SortFilterMapView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 17/06/23.
//

import SwiftUI

// 1
struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let age: Int
    let hasEmployment: Bool
}

// 1
class ModificationArrayViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    // 2 filtrar por algo específico
    @Published var filteredArray: [UserModel] = []
    // 9
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        // 4
        updateFilteredArray()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Juan Carlos", age: 58, hasEmployment: false)
        let user2 = UserModel(name: "Ana", age: 32, hasEmployment: false)
        let user3 = UserModel(name: "Alberto", age: 28, hasEmployment: true)
        let user4 = UserModel(name: "Luis", age: 19, hasEmployment: true)
        let user5 = UserModel(name: "Manuel", age: 65, hasEmployment: true)
        let user6 = UserModel(name: "Paula", age: 68, hasEmployment: false)
        let user7 = UserModel(name: "Jorge", age: 23, hasEmployment: false)
        let user8 = UserModel(name: "Angelina", age: 33, hasEmployment: true)
        let user9 = UserModel(name: "Alicia", age: 45, hasEmployment: false)
        let user10 = UserModel(name: "Mario", age: 18, hasEmployment: false)
        let user11 = UserModel(name: "Cristina", age: 38, hasEmployment: true)
        let user12 = UserModel(name: "José", age: 71, hasEmployment: false)
        
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
            user11,
            user12,
        ])
    }
    
    // 3
    func updateFilteredArray() {
        // Sort
        /*
        filteredArray = dataArray.sorted { user1, user2 in
            return user1.age < user2.age
        }
        // 6
        filteredArray = dataArray.sorted(by: { $0.age > $1.age })
         */
        
        // Filter
        // 7
        /*
        filteredArray = dataArray.filter( { user -> Bool in
            // return !user.hasEmployment
            return user.name.contains("a")
        })
        // 8 forma corta
        filteredArray = dataArray.filter( { $0.hasEmployment })
         */
        
        // Map
        // 11
        /*
        mappedArray = dataArray.map({ user -> String in
            return user.name
        })
        // 12
        mappedArray = dataArray.map( { $0.name })
         */
        
        // Combinar
//        let sort = dataArray.sorted(by: { $0.age > $1.age })
//        let filter = dataArray.filter { $0.hasEmployment }
//        let map = dataArray.compactMap { $0.name }
        
        mappedArray = dataArray
            .sorted(by: { $0.age > $1.age })
            .filter { $0.hasEmployment }
            .compactMap { $0.name }
        
    }
}

struct SortFilterMapView: View {
    
    // 1
    @StateObject var vm = ModificationArrayViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
//                ForEach(vm.dataArray) { user in
                // 5
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.title3)
//
//                        HStack {
//                        Text("Edad: \(user.age)")
//
//                        Spacer()
//                            if user.hasEmployment {
//                                Image(systemName: "star.fill")
//                            }
//                        } // HStack
//                    } // VStack
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.green.cornerRadius(12))
//                    .padding(.horizontal)
//                }
                // 11 comentar arriba el ForEach
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
            }
        } // Scroll
    }
}

struct SortFilterMapView_Previews: PreviewProvider {
    static var previews: some View {
        SortFilterMapView()
    }
}

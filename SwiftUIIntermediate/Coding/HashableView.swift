//
//  HashableView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 06/06/23.
//

import SwiftUI

/*
 Hashable crea un id único para cada elemento
 */

// 4
//struct CustomModel {
//    let petName: String
//}

// 6 ya mostrado el hash value en el text
struct CustomModel: Hashable {
    let petName: String
    // 8 se pueden combinar más elementos
    let age: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(petName)
        hasher.combine(petName + String(age))
    }
}

struct HashableView: View {
    // 1
//    let data = ["Coffe", "Fiona", "Booker", "Lucrecia"]
    // 5
    let data: [CustomModel] = [
        CustomModel(petName: "Coffe", age: 18),
        CustomModel(petName: "Fionna", age: 9),
        CustomModel(petName: "Booker", age: 3),
        CustomModel(petName: "Lucrecia", age: 3)
    ]
    // 9 observar como el hashvalue cambia al añadir la edad
    
    var body: some View {
        // 2
        ScrollView {
            VStack(spacing: 20) {
                // Se usa id porque los strings se apegan al protócolo hashable
                // podemos ver el hashvalue
                ForEach(data, id: \.self) { item in
                    // 3
//                    Text(item)
                    Text(item.hashValue.description)
                    // 7
                    Text(item.petName)
                        .font(.title)
                } // Loop
            } // VStack
            .padding(.top, 16)
        } // Scroll
    }
}

struct HashableView_Previews: PreviewProvider {
    static var previews: some View {
        HashableView()
    }
}

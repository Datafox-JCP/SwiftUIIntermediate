//
//  NavigationStackView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 09/06/23.
//

import SwiftUI

/*
 NavigationLink sólo permite pasar a 1 pantalla no a múltiples
 NavigationStack tiene lazyLoading
 
 */

struct NavigationStackView: View {
    
    // 10
    let fruits = ["Manzana", "Naranja", "Platano"]
    
    // 13
    @State private var stackPath: [String] = []
    
    // 1
    var body: some View {
        // 14
        NavigationStack(path: $stackPath) {
        // 7 convertir a NavigationStack
//        NavigationStack {
//            NavigationView {
            // 4 poner dentro del foreach el navlink
            // 5 poner todo dentro del scroll
            // observar como en background ya se crearon los views
            ScrollView {
                // 6 poner todo dentro de un VStack
                VStack(spacing: 20){
                    // 14 añadir una ruta
                    Button("Nuevas ventanas") {
                        stackPath.append(contentsOf: [
                            "Coco", "Melón", "Mango"
                        ])
                    }
                    
                    // 11
                    ForEach(fruits, id:\.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit)
                        }
                    }
                    ForEach(0..<10) { x in
                        // 9 y comentar el primer Nav
                        // observar como ahora la carga es lazy
                        NavigationLink(value: x) {
                            Text("Presiona aquí")
                        }
//                        NavigationLink {
//        //                Text("SwiftUI Intermedio")
//                                // 3 comentar arriba y poner
//                            SecondScreen(value: x)
//                        } label: {
//                            Text("Presiona aquí")
//                        }
                    }
                }
            }
            .navigationTitle("Datafox")
            // 8
            .navigationDestination(for: Int.self) { value in
                SecondScreen(value: value)
            }
            // 12 podemos tener diferentes destinos para diferentes tipos de datos
            .navigationDestination(for: String.self) { value in
                Text("Nueva pantalla: \(value)")
            }
        }
    }
}

// 2
struct SecondScreen: View {
    let value: Int
    
    init(value: Int) {
        self.value = value
        print("Init para pantalla: \(value)")
    }
    
    var body: some View {
        Text("Segunda pantalla del app")
    }
}

struct NavigationStackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackView()
    }
}

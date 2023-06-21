//
//  ToolbarView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 07/06/23.
//

import SwiftUI

struct ToolbarView: View {
    // 5
    @State private var name = ""
    // 14
    @State private var paths: [String] = []
    
    // 8
    private var images = ["Imagen1", "Imagen2", "Imagen3", "Imagen4", "Imagen5", "Imagen6", "Imagen7", "Imagen8", "Imagen9", "Imagen10", "Imagen11", "Imagen12"]
    
    // 1
    var body: some View {
        // 15
//        NavigationStack
        NavigationStack(path: $paths) {
            ZStack {
                Color.indigo.ignoresSafeArea()
                    .opacity(0.5)
                
//                Text("Hola, 🐱")
//                    .foregroundColor(.white)
//                    .font(.title)
                
                // 4 agregar Textfield
                ScrollView {
                    Text("Hola, 🐱")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.top, 16)
                    
                    TextField("Ingrese su nombre", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    
                    // 9
                    ForEach(images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    } // Loop
                        
                }
            } // ZStack
            .navigationTitle("SwiftUI Intermedio")
            // 2 comentar esto se va a depreciar:
//            .navigationBarItems(
//                leading: Image(systemName: "leaf"),
//                trailing: Image(systemName: "apple.logo")
//            )
//            .foregroundColor(.white)
            // 3 mostrar nuevo
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "leaf")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "apple.logo")
                }
                // 6 mostrar diferentes ubicaciones y en el emulador el teclado
                ToolbarItem(placement: .keyboard) {
                    Image(systemName: "gear")
                }
            } // Toolbar
            // 7 mostrar otras opciones
            .toolbar(.automatic, for: .navigationBar)
            // 10
            .toolbarBackground(.hidden, for: .navigationBar)
            // 11
            .toolbarColorScheme(.dark, for: .navigationBar)
            // 12
            .navigationBarTitleDisplayMode(.inline)
            // 13
            .toolbarTitleMenu {
                Button {
                    // 17
                    paths.append("Pantalla 1")
                } label: {
                    Image(systemName: "gear")
                    Text("Configuración")
                }
                Button("Opción 2") {
                    // 18
                    paths.append("Pantalla 2")
                }
            }
            // 16
            .navigationDestination(for: String.self) { value in
                Text("Nueva pantalla \(value)")
            }
        } // Nav
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}

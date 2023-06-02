//
//  MultipleSheetsView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 02/06/23.
//

import SwiftUI

// 2
struct MessageModel: Identifiable {
    let id = UUID().uuidString
    let message: String
}

struct MultipleSheetsView: View {
    
    // Al llegar al paso 7, mostrar como muestra mal la primera vez y de forma correcta las siguientes
    // el problema es poque el sheet es creado al crear la la view y con ello el primer DataModel tiene los datos predeterminados
    // Solcuiones
    // 1 Usar binding
    // 2 Usar varias sheets
    // 3 Usar $item
    
    // 3
    @State private var selectedModel: MessageModel = MessageModel(message: "SwiftUI con Datafox")
    // 4
    @State private var showSheet = false
    // 11 para solución 2
    @State private var showSecondSheet = false
    
    // 1
    var body: some View {
        VStack(spacing: 20) {
            Button("Primer botón") {
                // 4
                selectedModel = MessageModel(message: "SwiftUI Fundamentos")
                // 7
                showSheet.toggle()
            }
            
            Button("Segundo botón") {
                // 4
                // 13 con esta opción se puede comentar la línea de selectedModel
                selectedModel = MessageModel(message: "SwiftUI Intermedio")
                // 7
//                showSheet.toggle()
                // 14 para opción 2
                showSecondSheet.toggle()
            }
            // 12 para solución 2 y hacer lo mismo con el botón 1 pero comentando el punto 5
            .sheet(isPresented: $showSecondSheet) {
                IntermediateScreen(selectedModel: MessageModel(message: "SwiftUI Intermedio"))
            }
        } // VStack
        // 5
        .sheet(isPresented: $showSheet) {
            // 6
//            IntermediateScreen(selectedModel: selectedModel)
            // 8 cambiar a
//            IntermediateScreen(selectedModel: $selectedModel)
            // 10 para solución 2
            IntermediateScreen(selectedModel: selectedModel)
        }
    }
}

struct MultipleSheetsView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsView()
    }
}

// 5
struct IntermediateScreen: View {
    // 8 para solución 1
//    let selectedModel: MessageModel
//    @Binding var selectedModel: MessageModel
    // 9 para solución 2
    let selectedModel: MessageModel
    
    var body: some View {
        Text(selectedModel.message)
            .font(.largeTitle)
    }
}

//
//  MultipleSheets2View.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 02/06/23.
//

import SwiftUI

struct MultipleSheets2View: View {
        // Solución 3
        
        // 3
        @State private var selectedModel: MessageModel? = nil
        
        // 1
        var body: some View {
            VStack(spacing: 20) {
                Button("Primer botón") {
                    selectedModel = MessageModel(message: "SwiftUI Fundamentos")
                }
                
                Button("Segundo botón") {
                    selectedModel = MessageModel(message: "SwiftUI Intermedio")
                }
            } // VStack
            // 5
            .sheet(item: $selectedModel) { model in
                IntermediateScreen(selectedModel: model)
            }
        }
}

struct MultipleSheets2View_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheets2View()
    }
}

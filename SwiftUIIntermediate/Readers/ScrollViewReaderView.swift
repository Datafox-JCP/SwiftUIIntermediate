//
//  ScrollViewReaderView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 01/06/23.
//

import SwiftUI

struct ScrollViewReaderView: View {
    
    // 10 añadir state
    @State var textFieldText = ""
    // 11 satate para el index
    @State var scrolltoIndex = 0
    
    // 1
    var body: some View {
        // 8 poner todo dentro de un Vstack
        VStack {
            // 9 añadir textfield
            TextField("Ingrese número", text: $textFieldText)
                .frame(height: 40)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            // 10 mover el botón y ajustar
            Button("Desplazarse") {
                    // proxy.scrollTo(49)
                    // 6 demostrar lo que pasa con anchor (top, bottom, center
                    // 7 añadir la animación
                withAnimation(.spring()) {
                    // 12 añadir
                    if let index = Int(textFieldText) {
                        scrolltoIndex = index
                    }
                }
            }
            
            ScrollView {
                    // 2 // añadir Reader
                ScrollViewReader { proxy in // proxy lee la posición de cada elemento
                                            // 3 // mover el foreach al interior del reader
                                            // 4 añadir botón
//                    Button("Clic aquí para ir al final") {
//                            // proxy.scrollTo(49)
//                            // 6 demostrar lo que pasa con anchor (top, bottom, center
//                            // 7 añadir la animación
//                        withAnimation(.spring()) {
//                            proxy.scrollTo(30, anchor: .center)
//                        }
//                    }
                    ForEach(0..<50) { index in
                        Text("Mensaje número: \(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 12)
                            .padding()
                            // 5 añadir el id para que el reader sepa
                            .id(index)
                    } // Loop
                    // añadir
                    .onChange(of: scrolltoIndex) { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .top)
                        }
                    }
                } // Reader
            } // ScrollView
        } // VStack
    }
}

struct ScrollViewReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderView()
    }
}

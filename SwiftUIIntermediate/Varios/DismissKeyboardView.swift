//
//  DismissKeyboardView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 03/07/23.
//

import SwiftUI

struct DismissKeyboardView: View {
    @State private var text = ""
    @State private var tipAmount = ""
    @State private var name = ""
    @FocusState private var nameIsFocused: Bool

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Ingresa tus comentarios")
                Spacer()
                Button {
                    self.hideKeyboard()
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            } // HStack
            TextEditor(text: $text)
                .frame(width: .infinity, height: 200.0)
                .font(.title2)
                .border(Color.gray, width: 1)
                .lineLimit(10)
            
            TextField("Cantidad propinda", text: $tipAmount)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            Button("Calcular") {
                print("Propina: \(tipAmount)")
                hideKeyboard()
            }
            
            // Para iOS 15 +
            TextField("Escribe tu nombre", text: $name)
                .focused($nameIsFocused)
            
            Button("Guardar") {
                nameIsFocused = false
            }
            
        } // VStack
        .padding(.horizontal)
    }
}

extension DismissKeyboardView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct DismissKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        DismissKeyboardView()
    }
}

//
//  AccesibilityDynamicColorsView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 15/10/23.
//

import SwiftUI

struct AccesibilityDynamicColorsView: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Botón 1") {
                    
                }
                .foregroundColor(colorSchemeContrast == .increased ? Color.white : .primary)
                .buttonStyle(.borderedProminent)
                
                Button("Botón 2") {
                    
                }
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                
                Button("Botón 3") {
                    
                }
                .foregroundStyle(differentiateWithoutColor ? .white : .red)
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                .tint(differentiateWithoutColor ? .black : .blue)
                
                Button("Botón 4") {
                    
                }
                .foregroundStyle(.green)
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
            }
            .font(.largeTitle)
            .navigationTitle("Colors")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(reduceTransparency ? Color.black :  Color.black.opacity(0.5))
        }
    }
}

#Preview {
    AccesibilityDynamicColorsView()
}

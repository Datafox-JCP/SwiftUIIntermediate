//
//  ContentTransitionEffectsView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 06/09/23.
//

import SwiftUI

struct ContentTransitionEffectsView: View {
    
    @State private var text = 0
    @State private var sfImage = "house.fill"
    @State private var sfCount = 1
    
    var body: some View {
        VStack {
            Image(systemName: sfImage)
                .resizable()
                .font(.largeTitle.bold())
                .contentTransition(.symbolEffect(.automatic))
                .frame(width: 75, height: 75)
            
            Button {
                let images = ["suit.heart.fill", "house.fill", "gearshape", "person.circle.fill", "iphone", "macbook", "apple.logo"]
                withAnimation(.interactiveSpring) {
                    sfCount += 1
                    sfImage = images[sfCount % images.count]
                }
            } label: {
                Text("Cambiar imagen")
            }
            .padding()
            
            Text("$\(text)")
                .font(.largeTitle.bold())
                .contentTransition(.numericText(value: Double(text)))
            
            Button {
                withAnimation(.bouncy) {
                    text = .random(in: 100...100_000)
                }
            } label: {
                Text("Actualizar")
            }
            .padding()
            
        } // VStack

    }
}

#Preview {
    ContentTransitionEffectsView()
}

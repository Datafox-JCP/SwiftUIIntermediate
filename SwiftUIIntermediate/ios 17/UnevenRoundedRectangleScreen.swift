//
//  UnevenRoundedRectangleScreen.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 15/08/23.
//

import SwiftUI

struct UnevenRoundedRectangleScreen: View {
    @State private var animate = false
    
    var body: some View {
        VStack {
            Rectangle()
                .cornerRadius(10.0)
                .frame(width: 300, height: 70)
            
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 300, height: 70)
            
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 50.0,
                bottomLeading: 10.0,
                bottomTrailing: 50.0,
                topTrailing: 30.0
            ), style: .continuous)
            .frame(width: 300, height: 70)
            .foregroundStyle(.indigo)
            
            Button(action: {
                
            }) {
                Text("Registrarse")
                    .font(.title)
            }
            .tint(.white)
            .frame(width: 300, height: 70)
            .background {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 50.0,
                    bottomLeading: 10.0,
                    bottomTrailing: 50.0,
                    topTrailing: 30.0
                ), style: .continuous)
                .foregroundStyle(.indigo)
            }
            
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: animate ? 10.0: 70.0,
                bottomLeading: animate ? 70.0: 10.0,
                bottomTrailing: animate ? 70.0: 10.0,
                topTrailing: animate ? 10.0: 70.0
            ))
            .foregroundStyle(.indigo)
            .frame(width: 300, height: 70)
            .padding()
            .onTapGesture {
                withAnimation {
                    animate.toggle()
                }
            }
            .padding(.bottom, 70)
            
            
            ZStack {
                ForEach(0..<18, id: \.self) { index in
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: 20.0,
                        bottomLeading: 5.0,
                        bottomTrailing: 20.0,
                        topTrailing: 10.0
                    ), style: .continuous)
                    .foregroundStyle(.indigo)
                    .frame(width: 200, height: 30)
                    .opacity(animate ? 0.6 : 1.0)
                    .rotationEffect(.degrees(Double(10 * index)))
                    .animation(.easeInOut.delay(Double(index) * 0.02), value: animate)
                }
            }
            .overlay {
                Image(systemName: "briefcase")
                    .foregroundStyle(.white)
                    .font(.system(size: 100))
            }
            .onTapGesture {
                animate.toggle()
            }
            
        } // VStack
        .padding()
    }
}

#Preview {
    UnevenRoundedRectangleScreen()
}

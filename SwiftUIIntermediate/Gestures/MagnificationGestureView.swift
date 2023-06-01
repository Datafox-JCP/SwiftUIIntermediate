//
//  MagnificationGestureView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 31/05/23.
//

import SwiftUI

struct MagnificationGestureView: View {
    // 3
    @State var currentAmount: CGFloat = 0
    // 6
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        // 1
        VStack {
            // 9
            VStack(spacing: 10) {
                HStack {
                    Circle().frame(width: 35, height: 35)
                    Text("Taller SwiftUI Intermedio")
                    Spacer()
                    Image(systemName: "ellipsis")
                } // HStack
                .padding(.horizontal)
                
                Image("gato")
                    .resizable()
                    .scaledToFit()
                    // 11
                    .scaleEffect(1 + currentAmount)
                    .frame(height: 300)
                    // 10
                    .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                currentAmount = value - 1
                            }
                            .onEnded{ value in
                                withAnimation(.spring()) {
                                    currentAmount = 0
                                }
                            }
                    )
                
                HStack {
                    Image(systemName: "heart")
                    Image(systemName: "text.bubble")
                    Spacer()
                }
                .padding(.horizontal)
                .font(.headline)
                
                Text("Despertando...")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
            
            Spacer()
            // Comentar para el punto 9
            // MARK: Text
//            Text("Magnification Gesture")
//                .font(.title)
//                .padding(40)
//                .background(Color.red.cornerRadius(16))
//                // 4
//    //            .scaleEffect(1 + currentAmount)
//                // 8 (modificar la de arriba para que quede así
//                .scaleEffect(1 + currentAmount + lastAmount)
//                // 2
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged { value in
//                        // 5
//                            currentAmount = value - 1
//                        }
//                        // 7
//                        .onEnded { value in
//                            lastAmount += currentAmount
//                            currentAmount = 0
//                        }
//                )
        } // VStack
        
    }
}

struct MaginficationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureView()
    }
}
